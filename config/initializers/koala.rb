# config/initializers/koala.rb

module Facebook
 #CONFIG = YAML.load_file(Rails.root + "/config/facebook.yml")[Rails.env]
 APP_ID = "462973483793316"
 SECRET = "6ff4885299e94a24e3a29fe09e6184bd" 
 CALLBACK_URL = "http://localhost:3000/"
end

Koala::Facebook::OAuth.class_eval do
 def initialize_with_default_settings(*args)
 case args.size
 when 0, 1
 raise "application id and/or secret are not specified in the config" unless Facebook::APP_ID && Facebook::SECRET
 initialize_without_default_settings(Facebook::APP_ID.to_s, Facebook::SECRET.to_s, Facebook::CALLBACK_URL.to_s)
 when 2, 3
 initialize_without_default_settings(*args)
 end
 end

 alias_method_chain :initialize, :default_settings
end