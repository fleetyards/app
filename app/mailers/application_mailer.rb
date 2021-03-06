# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.app.mailer_default_from.to_s

  layout 'mailer'
end
