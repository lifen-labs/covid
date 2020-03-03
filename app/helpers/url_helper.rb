module UrlHelper

  extend ActiveSupport::Concern

  class Base
    include Rails.application.routes.url_helpers

    def default_url_options
      ActionMailer::Base.default_url_options
    end
  end

  def url_helper
    @url_helper ||= UrlHelper::Base.new
  end

  def self.method_missing method, *args, &block
    @url_helper ||= UrlHelper::Base.new

    if @url_helper.respond_to?(method)
      @url_helper.send(method, *args, &block)
    else
      super method, *args, &block
    end
  end

end