OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '462973483793316', '6ff4885299e94a24e3a29fe09e6184bd',
  			:scope => 'email,publish_actions, user_education_history, friends_education_history'
end

OmniAuth.config.on_failure = Proc.new do |env| new_path = "/auth/failure"
 [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
end