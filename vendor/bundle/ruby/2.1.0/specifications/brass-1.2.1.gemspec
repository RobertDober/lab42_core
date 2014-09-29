# -*- encoding: utf-8 -*-
# stub: brass 1.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "brass"
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Thomas Sawyer"]
  s.date = "2012-02-09"
  s.description = "BRASS stands for Bare-Metal Ruby Assertion System Standard. It is a very basic\nfoundational assertions framework for other assertion and test frameworks\nto make use so they can all work together harmoniously."
  s.email = ["transfire@gmail.com"]
  s.extra_rdoc_files = ["HISTORY.rdoc", "COPYING.rdoc", "README.md"]
  s.files = ["COPYING.rdoc", "HISTORY.rdoc", "README.md"]
  s.homepage = "http://rubyworks.github.com/brass"
  s.licenses = ["BSD-2-Clause"]
  s.rubygems_version = "2.2.2"
  s.summary = "Bare-Metal Ruby Assertion System Standard"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<detroit>, [">= 0"])
      s.add_development_dependency(%q<lemon>, [">= 0"])
      s.add_development_dependency(%q<rubytest>, [">= 0"])
    else
      s.add_dependency(%q<detroit>, [">= 0"])
      s.add_dependency(%q<lemon>, [">= 0"])
      s.add_dependency(%q<rubytest>, [">= 0"])
    end
  else
    s.add_dependency(%q<detroit>, [">= 0"])
    s.add_dependency(%q<lemon>, [">= 0"])
    s.add_dependency(%q<rubytest>, [">= 0"])
  end
end
