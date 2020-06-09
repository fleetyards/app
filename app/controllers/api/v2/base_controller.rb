# frozen_string_literal: true

module Api
  module V2
    class BaseController < ActionController::Base
      def root
        render 'api/v2/graphiql', layout: false
      end
    end
  end
end
