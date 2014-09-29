# -*- encoding: utf-8 -*-
# stub: facets 2.9.3 ruby lib/core lib/standard

Gem::Specification.new do |s|
  s.name = "facets"
  s.version = "2.9.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib/core", "lib/standard"]
  s.authors = ["Thomas Sawyer"]
  s.date = "2011-12-31"
  s.description = "Facets is the premier collection of extension methods for the Ruby programming language. Facets extensions are unique by virtue of thier atomicity. They are stored in individual files allowing for highly granular control of requirements. In addition, Facets includes a few additional classes and mixins suitable to wide variety of applications."
  s.email = ["transfire@gmail.com"]
  s.extra_rdoc_files = ["RUBY.txt", "HISTORY.rdoc", "README.rdoc", "NOTICE.rdoc"]
  s.files = ["HISTORY.rdoc", "NOTICE.rdoc", "README.rdoc", "RUBY.txt"]
  s.homepage = "http://rubyworks.github.com/facets"
  s.licenses = ["Ruby"]
  s.rubygems_version = "2.2.2"
  s.summary = "Premium Ruby Extensions"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<lemon>, [">= 0"])
      s.add_development_dependency(%q<qed>, [">= 0"])
      s.add_development_dependency(%q<detroit>, [">= 0"])
    else
      s.add_dependency(%q<lemon>, [">= 0"])
      s.add_dependency(%q<qed>, [">= 0"])
      s.add_dependency(%q<detroit>, [">= 0"])
    end
  else
    s.add_dependency(%q<lemon>, [">= 0"])
    s.add_dependency(%q<qed>, [">= 0"])
    s.add_dependency(%q<detroit>, [">= 0"])
  end
end
