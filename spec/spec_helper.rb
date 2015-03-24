lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "rails"
require 'reportly'

def make_basic_app
  @app = Class.new(Rails::Application)
  @app.config.secret_token = "3b7cd727ee24e8444053437c36cc66c4"
  @app.config.session_store :cookie_store, :key => "_myapp_session"
  @app.config.active_support.deprecation = :log
  @app.initialize!
end
