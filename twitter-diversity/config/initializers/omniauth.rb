Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["public"], ENV["secret"]
end