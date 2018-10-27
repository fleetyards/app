# frozen_string_literal: true

module Api
  module V1
    class ShopCommoditiesController < ::Api::V1::BaseController
      before_action :authenticate_api_user!, only: []
      after_action -> { pagination_header(:shop_commodities) }, only: [:index]

      def index
        authorize! :index, :api_shop_commodities
        sorts = [
          'name asc',
          'commodity_item_of_Model_type_name asc',
          'commodity_item_of_Component_type_name asc',
          'commodity_item_of_Commodity_type_name asc'
        ]
        query_params['sorts'] = sort_by_name(sorts, sorts)

        @q = shop.shop_commodities
                 .ransack(query_params)

        @shop_commodities = @q.result
                              .page(params[:page])
                              .per(per_page(ShopCommodity))
      end

      private def shop
        @shop ||= station.shops.visible.find_by!(slug: params[:shop_slug])
      end

      private def station
        @station ||= Station.visible.find_by!(slug: params[:station_slug])
      end
    end
  end
end
