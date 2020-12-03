# frozen_string_literal: true

require 'rsi/base_loader'

module Rsi
  class HardpointsLoader < ::Rsi::BaseLoader
    attr_accessor :components_loader

    def initialize(options = {})
      super

      self.components_loader = ::Rsi::ComponentsLoader.new
    end

    def hardpoint_types(sc_identifier = nil)
      return ModelHardpoint::SHIP_MATRIX_HARDPOINT_TYPES.keys if sc_identifier.present?

      ModelHardpoint::GAME_FILE_HARDPOINT_TYPES.keys + ModelHardpoint::SHIP_MATRIX_HARDPOINT_TYPES.keys
    end

    def run(data, model)
      hardpoint_ids = []

      hardpoints_data(data, model.sc_identifier).each do |hardpoint_data|
        (1..hardpoint_data[:mounts].to_i).each do |mount|
          hardpoint_ids << create_or_update(hardpoint_data, model.id, "#{hardpoint_data[:index]}-#{mount}").id
        end
      end

      ModelHardpoint.where(
        source: :ship_matrix,
        model_id: model.id,
        hardpoint_type: hardpoint_types(model.sc_identifier)
      ).where.not(id: hardpoint_ids)
        .update(deleted_at: Time.zone.now)
    end

    private def hardpoints_data(data, sc_identifier)
      data.values.map do |types|
        types.values.map do |values|
          values.each_with_index.map do |value, index|
            value.symbolize_keys.merge(index: index)
          end
        end
      end.flatten.select do |hardpoint_data|
        hardpoint_types(sc_identifier).include?(hardpoint_data[:type].to_sym)
      end
    end

    private def create_or_update(hardpoint_data, model_id, key)
      hardpoint = ModelHardpoint.find_or_create_by!(
        source: :ship_matrix,
        model_id: model_id,
        hardpoint_type: hardpoint_data[:type],
        group: component_class_to_group(hardpoint_data[:component_class]),
        key: key,
        size: size_mapping(hardpoint_data[:size])
      )

      hardpoint.update!(
        details: hardpoint_data[:details],
        category: category_mapping(hardpoint_data[:category]),
        quantity: hardpoint_data[:quantity],
        deleted_at: nil
      )

      components_loader.run(hardpoint_data, hardpoint)

      hardpoint
    end

    private def category_mapping(category)
      return if category.blank?

      mapping = {
        'M' => :main,
        'R' => :retro,
        'V' => :vtol,
        'F' => :fixed,
        'G' => :gimbal
      }

      raise "Category missing in Mapping \"#{category}\"" if mapping[category].blank?

      mapping[category]
    end

    private def component_class_to_group(component_class)
      mapping = {
        'RSIPropulsion' => :propulsion,
        'RSIAvionic' => :avionic,
        'RSIThruster' => :thruster,
        'RSIModular' => :system,
        'RSIWeapon' => :weapon
      }

      raise "Component Class missing in Group Mapping \"#{component_class}\"" if mapping[component_class].blank?

      mapping[component_class]
    end

    private def size_mapping(size)
      return size.to_i if numeric?(size)

      undefined_size = 'undefined'

      mapping = {
        'TBD' => undefined_size,
        '-' => undefined_size,
        'V' => 0,
        'S' => 1,
        'M' => 2,
        'L' => 3,
        'C' => 4
      }

      raise "Size missing in Mapping \"#{size}\"" if mapping[size.strip].blank?

      return nil if mapping[size.strip] == undefined_size

      mapping[size.strip]
    end

    private def numeric?(value)
      value.to_s == value.to_i.to_s
    end
  end
end
