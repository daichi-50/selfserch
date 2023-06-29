Rails.application.config.action_cable.mount_path = '/cable'

if Rails.env.development?
    Rails.application.config.action_cable.allowed_request_origins = ['http://localhost:300']
elsif Rails.env.production?
    Rails.application.config.action_cable.allowed_request_origins = ['https://selfserch.herokuapp.com', 'http://<your-custom-domain>.com']
end

Rails.application.config.action_cable.disable_request_forgery_protection = true