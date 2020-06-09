# frozen_string_literal: true

scope :v2, as: :v2 do
  post '/' => 'v2/graphql#execute'
  root to: 'v2/base#root'
end
