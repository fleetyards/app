# frozen_string_literal: true

module Api
  module V1
    class CelestialObjectsController < ::Api::V1::BaseController
      before_action :authenticate_api_user!, only: []
      after_action -> { pagination_header(:celestial_objects) }, only: [:index]

      def index
        authorize! :index, :api_celestial_objects

        query_params['sorts'] = sort_by_name('designation asc', 'designation asc')

        @q = CelestialObject.visible
                            .ransack(query_params)

        @celestial_objects = @q.result
                               .page(params[:page])
                               .per(per_page(CelestialObject))
      end

      def show
        authorize! :show, :api_celestial_objects
        @celestial_object = CelestialObject.visible.find_by!(slug: params[:slug])
      end
    end
  end
end
