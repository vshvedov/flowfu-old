# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_workfu_session',
  :secret      => '341d6056ad3c6f6634bc9e669f59eeee32b5d47bf44046333a9a49882ff3e44d51620c9db594b6233b3b18e20f5aa5f9ef2e7ad965772f1dfbfbaecc894ad1e6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
