# frozen_string_literal: true

module Api
  module V1
    class ShopsController < ::Api::V1::BaseController
      before_action :authenticate_api_user!, only: []

      def show
        authorize! :show, :api_shops
        @shop = station.shops.visible.find_by!(slug: params[:slug])
      end

      private def station
        @station ||= Station.visible.find_by!(slug: params[:station_slug])
      end
    end
  end
end
