# -*- encoding: utf-8 -*-
# stub: forwarder2 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "forwarder2"
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Robert Dober"]
  s.date = "2013-09-17"
  s.description = "Ruby's core Forwardable gets the job done(barely) and produces most unreadable code. \n\n  Forwarder2 not only is more readable, much more feature rich, but also slightly faster, meaning you can use it without performance penalty.\n\n  Additional features include: providing arguments, (partially if needed), AOP and custom forwarding to hashes\n  "
  s.email = "robert.dober@gmail.com"
  s.homepage = "https://github.com/RobertDober/Forwarder2"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0")
  s.rubygems_version = "2.2.2"
  s.summary = "Delegation And AOP Filters For It"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
      s.add_development_dependency(%q<pry>, ["~> 0.9"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.14"])
      s.add_dependency(%q<pry>, ["~> 0.9"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.14"])
    s.add_dependency(%q<pry>, ["~> 0.9"])
  end
end
