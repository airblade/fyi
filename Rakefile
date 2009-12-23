require 'rake' 

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'fyi'
    gemspec.summary = 'Find out what cron is doing.'
    gemspec.email = 'boss@airbladesoftware.com'
    gemspec.homepage = 'http://github.com/airblade/fyi'
    gemspec.authors = ['Andy Stewart']
    gemspec.add_dependency('pony')
    gemspec.add_dependency('systemu')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler'
end
