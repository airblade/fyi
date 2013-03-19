# -*- encoding: utf-8 -*-

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
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

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables        = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths      = %w[ lib ]

  s.add_development_dependency 'rake', '0.9.2.2'
  s.add_dependency 'mail',    '~> 2.5.3'
  s.add_dependency 'systemu', '>= 2.4.0'
end
