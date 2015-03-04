# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Convert keynames from the standard ruby_format to camelCase.
Jbuilder.key_format camelize: :lower

