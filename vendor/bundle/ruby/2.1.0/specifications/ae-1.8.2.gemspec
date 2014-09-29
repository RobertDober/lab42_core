# -*- encoding: utf-8 -*-
# stub: ae 1.8.2 ruby lib

Gem::Specification.new do |s|
  s.name = "ae"
  s.version = "1.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Trans"]
  s.date = "2013-02-18"
  s.description = "Assertive Expressive is an assertions library specifically designed \nfor reuse by other test frameworks."
  s.email = ["transfire@gmail.com"]
  s.extra_rdoc_files = ["DEMO.rdoc", "HISTORY.md", "README.md", "NOTICE.md"]
  s.files = ["DEMO.rdoc", "HISTORY.md", "NOTICE.md", "README.md"]
  s.homepage = "http://rubyworks.github.com/ae"
  s.licenses = ["BSD-2-Clause"]
  s.rubygems_version = "2.2.2"
  s.summary = "Assertive Expressive"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ansi>, [">= 0"])
      s.add_development_dependency(%q<detroit>, [">= 0"])
      s.add_development_dependency(%q<qed>, [">= 0"])
    else
      s.add_dependency(%q<ansi>, [">= 0"])
      s.add_dependency(%q<detroit>, [">= 0"])
      s.add_dependency(%q<qed>, [">= 0"])
    end
  else
    s.add_dependency(%q<ansi>, [">= 0"])
    s.add_dependency(%q<detroit>, [">= 0"])
    s.add_dependency(%q<qed>, [">= 0"])
  end
end
