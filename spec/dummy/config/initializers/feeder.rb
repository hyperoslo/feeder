class AuthorizationAdapter < Feeder::AuthorizationAdapters::Base
  def authorized? action, subject
    subject.present?
  end
end

Feeder.configure do |config|
  config.current_user_method   = "current_user"
  config.authorization_adapter = AuthorizationAdapter
end
