
require 'simplecov'
SimpleCov.start

require_relative "../lib/lab42/core"
require_relative "../lib/lab42/core/meta"

PROJECT_ROOT = File.expand_path "../..", __FILE__
Dir[File.join(PROJECT_ROOT,"spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |c|
  c.filter_run wip: true
  c.run_all_when_everything_filtered = true
end

