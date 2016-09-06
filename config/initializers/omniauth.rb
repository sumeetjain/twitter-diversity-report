Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["PUBLIC"], ENV["SECRET"]
end
