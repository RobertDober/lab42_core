# -*- encoding: utf-8 -*-
# stub: qed 2.9.1 ruby lib

Gem::Specification.new do |s|
  s.name = "qed"
  s.version = "2.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Trans"]
  s.date = "2013-02-18"
  s.description = "QED (Quality Ensured Demonstrations) is a TDD/BDD framework\nutilizing Literate Programming techniques."
  s.email = ["transfire@gmail.com"]
  s.executables = ["qedoc", "qed"]
  s.extra_rdoc_files = ["LICENSE.txt", "HISTORY.md", "README.md"]
  s.files = ["HISTORY.md", "LICENSE.txt", "README.md", "bin/qed", "bin/qedoc"]
  s.homepage = "http://rubyworks.github.com/qed"
  s.licenses = ["BSD-2-Clause"]
  s.rubygems_version = "2.2.2"
  s.summary = "Quod Erat Demonstrandum"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ansi>, [">= 0"])
      s.add_runtime_dependency(%q<brass>, [">= 0"])
      s.add_runtime_dependency(%q<facets>, [">= 2.8"])
      s.add_development_dependency(%q<blankslate>, [">= 0"])
      s.add_development_dependency(%q<ae>, [">= 0"])
      s.add_development_dependency(%q<detroit>, [">= 0"])
      s.add_development_dependency(%q<ergo>, [">= 0"])
    else
      s.add_dependency(%q<ansi>, [">= 0"])
      s.add_dependency(%q<brass>, [">= 0"])
      s.add_dependency(%q<facets>, [">= 2.8"])
      s.add_dependency(%q<blankslate>, [">= 0"])
      s.add_dependency(%q<ae>, [">= 0"])
      s.add_dependency(%q<detroit>, [">= 0"])
      s.add_dependency(%q<ergo>, [">= 0"])
    end
  else
    s.add_dependency(%q<ansi>, [">= 0"])
    s.add_dependency(%q<brass>, [">= 0"])
    s.add_dependency(%q<facets>, [">= 2.8"])
    s.add_dependency(%q<blankslate>, [">= 0"])
    s.add_dependency(%q<ae>, [">= 0"])
    s.add_dependency(%q<detroit>, [">= 0"])
    s.add_dependency(%q<ergo>, [">= 0"])
  end
end
