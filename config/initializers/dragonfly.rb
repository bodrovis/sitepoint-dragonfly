require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  protect_from_dos_attacks true
  secret "022767dc5c42345e7a535fc55bf521bb950920a212eb1d7559ea678dc74d0771"

  url_format "/media/:job/:name"

  # datastore :file,
  #   root_path: Rails.root.join('public/system/dragonfly', Rails.env),
  #   server_root: Rails.root.join('public')

  datastore :s3,
            bucket_name: 'bodrov_sitepoint',
            access_key_id: 'AKIAJDMUKFSJNODLJ52Q',
            secret_access_key: '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',
            url_scheme: 'https'
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
