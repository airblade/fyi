# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fyi}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andy Stewart"]
  s.date = %q{2010-05-17}
  s.default_executable = %q{fyi}
  s.email = %q{boss@airbladesoftware.com}
  s.executables = ["fyi"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".gitignore",
     "README.md",
     "Rakefile",
     "VERSION",
     "bin/fyi",
     "config_example.yml",
     "fyi.gemspec",
     "lib/fyi.rb",
     "lib/fyi/config.rb",
     "lib/fyi/core_ext.rb",
     "lib/fyi/notifiers/email.rb",
     "lib/fyi/notifiers/log.rb"
  ]
  s.homepage = %q{http://github.com/airblade/fyi}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Find out what cron is doing.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pony>, [">= 0"])
      s.add_runtime_dependency(%q<systemu>, [">= 0"])
    else
      s.add_dependency(%q<pony>, [">= 0"])
      s.add_dependency(%q<systemu>, [">= 0"])
    end
  else
    s.add_dependency(%q<pony>, [">= 0"])
    s.add_dependency(%q<systemu>, [">= 0"])
  end
end

