# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift 'lib'
require 'fyi/version'

Gem::Specification.new do |s|
  s.name               = 'fyi'
  s.version            = Fyi::VERSION
  s.date               = Time.now.strftime('%Y-%m-%d')
  s.summary            = 'Find out what cron is doing.'
  s.description        = s.summary
  s.homepage           = 'http://github.com/airblade/fyi'
  s.authors            = ['Andy Stewart']
  s.email              = 'boss@airbladesoftware.com'
  s.files              = %w( README.md Rakefile fyi.gemspec config_example.yml )
  s.files             += Dir.glob("bin/**/*")
  s.files             += Dir.glob("lib/**/*")
  s.executables        = %w( fyi )
  s.extra_rdoc_files   = %w( README.md )
  s.add_dependency 'pony',    ['>= 0']
  s.add_dependency 'systemu', ['>= 0']
end
