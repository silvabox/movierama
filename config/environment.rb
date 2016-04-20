# Load the Rails application.
require File.expand_path('../application', __FILE__)

Rails.application.configure do
  config.autoload_paths += %W(#{config.root}/app/services)

  config.middleware.use ActionDispatch::Flash
  # config.middleware.insert 0, Rack::SSL
end

# Initialize the Rails application.
Rails.application.initialize!
