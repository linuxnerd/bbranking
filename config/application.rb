require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bbranking
  class Application < Rails::Application
    config.assets.precompile << Proc.new { |path|
      if path =~ /\.(eot|svg|ttf|woff)\z/
        true
      end
    }
  end
end
