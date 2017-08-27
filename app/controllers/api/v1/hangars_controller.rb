# encoding: utf-8
# frozen_string_literal: true

module Api
  module V1
    class HangarsController < ::Api::BaseController
      skip_authorization_check only: [:public]
      before_action :authenticate_api_user!, except: [:public]

      def show
        authorize! :show, :api_hangar
        @user_ships = current_user.user_ships
                                  .unscoped
                                  .order(purchased: :desc, name: :asc, created_at: :desc)
      end

      def public
        user = User.find_by!("lower(username) = ?", params.fetch(:username, '').downcase)
        @user_ships = user.user_ships
                          .unscoped
                          .purchased
                          .order(name: :asc, created_at: :desc)
      end
    end
  end
end
