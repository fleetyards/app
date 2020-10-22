# frozen_string_literal: true

require 'rsi/news_loader'

class RsiNewsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: (ENV['RSI_NEWS_QUEUE'] || 'fleetyards_rsi_news_loader').to_sym

  def perform
    ::Rsi::NewsLoader.new.update
  end
end
