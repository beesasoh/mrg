OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '462973483793316', '6ff4885299e94a24e3a29fe09e6184bd',
  			:scope => 'email,friends_list,friends_education_history',
  			:display => 'popup'
end