# -*- encoding: utf-8 -*-
# stub: lab42_tmux2 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "lab42_tmux2"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Robert Dober"]
  s.date = "2014-08-18"
  s.description = "Create sessions with multiple windows from ruby"
  s.email = "robert.dober@gmail.com"
  s.homepage = "https://github.com/RobertDober/lab42_tmux"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1")
  s.rubygems_version = "2.2.2"
  s.summary = "Creating Tmux Windows And Panes Without Pains"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<forwarder2>, ["~> 0.2"])
      s.add_development_dependency(%q<pry>, ["~> 0.9.12"])
      s.add_development_dependency(%q<pry-nav>, ["~> 0.2.4"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
    else
      s.add_dependency(%q<forwarder2>, ["~> 0.2"])
      s.add_dependency(%q<pry>, ["~> 0.9.12"])
      s.add_dependency(%q<pry-nav>, ["~> 0.2.4"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<forwarder2>, ["~> 0.2"])
    s.add_dependency(%q<pry>, ["~> 0.9.12"])
    s.add_dependency(%q<pry-nav>, ["~> 0.2.4"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
  end
end
