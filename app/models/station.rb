# frozen_string_literal: true

class Station < ApplicationRecord
  paginates_per 30

  has_many :shops, dependent: :destroy
  has_many :docks, dependent: :destroy
  has_many :habitations, dependent: :destroy

  has_many :images,
           as: :gallery,
           dependent: :destroy,
           inverse_of: :gallery

  belongs_to :planet

  enum station_type: %i[spaceport hub rest_stop station cargo-station mining-station asteroid-station refinery district outpost aid_shelter]

  validates :name, :station_type, :location, :planet, presence: true
  validates :name, uniqueness: true

  before_save :update_slugs

  mount_uploader :store_image, StoreImageUploader
  mount_uploader :map, ImageUploader

  accepts_nested_attributes_for :docks, allow_destroy: true

  delegate :starsystem, to: :planet

  def self.visible
    where(hidden: false)
  end

  def image
    images.first
  end

  def habitation_counts
    habitations.group_by(&:habitation_type).map do |habitation_type, habitations_by_type|
      OpenStruct.new(habitation_type: habitation_type, habitation_type_label: habitations_by_type.first.habitation_type_label, count: habitations_by_type.size)
    end.flatten
  end

  def dock_counts
    docks.to_a.group_by(&:ship_size).map do |size, docks_by_size|
      docks_by_size.group_by(&:dock_type).map do |dock_type, docks_by_type|
        OpenStruct.new(size: size, dock_type: dock_type, dock_type_label: docks_by_type.first.dock_type_label, count: docks_by_type.size)
      end
    end.flatten
  end

  def station_type_label
    Station.human_enum_name(:station_type, station_type)
  end

  private def update_slugs
    self.slug = SlugHelper.generate_slug(name)
  end
end
