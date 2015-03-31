Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["public"], ENV["secret"]
  # right now these are defined with Sumeet's keys for another application
end