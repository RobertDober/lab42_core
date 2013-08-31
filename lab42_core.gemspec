$:.unshift( File.expand_path( "../lib", __FILE__ ) )
require 'lab42/core/version'
version = Lab42::Core::VERSION
Gem::Specification.new do |s|
  s.name        = 'lab42_core'
  s.version     = version
  s.summary     = "What I am missing in Ruby"
  s.description = %{Hash, Dir and more extensions}
  s.authors     = ["Robert Dober"]
  s.email       = 'robert.dober@gmail.com'
  s.files       = Dir.glob("lib/**/*.rb")
  s.files      += %w{LICENSE README.md}
  s.homepage    = "https://github.com/RobertDober/lab42_core"
  s.licenses    = %w{MIT}

  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency 'pry', '~> 0.9.12'
  s.add_development_dependency 'rspec', '~> 2.13.0'
end
