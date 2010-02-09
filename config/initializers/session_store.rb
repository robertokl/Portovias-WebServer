# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_porto_session',
  :secret      => '0974fb4ebd3dbb3d17057da646626630beda2bd36cf85d4357c4083bf34e2cc2b35c4c5a522a7501ec84e3c1aa19b4693f7894604c3bbb7e6e5e6b11e5fd6e75'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
