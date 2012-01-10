# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LehaziCom::Application.initialize!

Time::DATE_FORMATS[:china] = "%Y-%m-%d %H:%M"