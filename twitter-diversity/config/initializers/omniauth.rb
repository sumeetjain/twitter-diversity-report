Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["public"], ENV["secret"]
  
  class SafeFailureEndpoint < OmniAuth::FailureEndpoint
   def call
     redirect_to_failure
   end
  end

  OmniAuth.config.on_failure = SafeFailureEndpoint
  # right now these are defined with Sumeet's keys for another application
end