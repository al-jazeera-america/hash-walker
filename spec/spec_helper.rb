$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'hash-walker'

RSpec.configure do |config|
  config.backtrace_exclusion_patterns = []

end