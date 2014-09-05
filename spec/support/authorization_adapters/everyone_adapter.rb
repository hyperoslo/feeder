class EveryoneAdapter < Feeder::AuthorizationAdapters::Base
  def authorized? action, subject
    true
  end
end
