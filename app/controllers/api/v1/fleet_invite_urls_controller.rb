# frozen_string_literal: true

module Api
  module V1
    class FleetInviteUrlsController < ::Api::BaseController
      after_action -> { pagination_header(:fleet_invite_urls) }, only: %i[index]

      def index
        authorize! :show, fleet

        scope = fleet.fleet_invite_urls

        scope.order(created_at: :desc)

        @fleet_invite_urls = scope
          .page(params[:page])
          .per(per_page(FleetInviteUrl))
      end

      def exists
        authorize! :exists, :api_fleet_invite_url

        fleet = Fleet.where(slug: params[:fleet_slug]).first!
        fleet.fleet_invite_urls
          .where(token: params[:token])
          .first!

        render json: true, status: :ok
      end

      def show
        authorize! :show, fleet_invite_url
      end

      def create
        @fleet_invite_url = fleet.fleet_invite_urls.new(user_id: current_user.id)

        authorize! :create, fleet_invite_url

        return if fleet_invite_url.save

        render json: ValidationError.new('fleet_invite_urls.create', fleet_invite_url.errors), status: :bad_request
      end

      def destroy
        @fleet_invite_url = fleet.fleet_invite_urls.find_by!(token: params[:token])

        authorize! :destroy, fleet_invite_url

        if fleet_invite_url.destroy
          render json: nil, status: :ok
        else
          render json: ValidationError.new('fleet_invite_urls.destroy', fleet_invite_url.errors), status: :bad_request
        end
      end

      private def fleet_invite_url
        @fleet_invite_url ||= fleet.fleet_invite_urls
          .where(token: params[:token])
          .first!
      end

      private def fleet
        @fleet ||= current_user.fleets.where(slug: params[:fleet_slug]).first!
      end
    end
  end
end