$LOAD_PATH.unshift 'lib'
require 'fyi/version'

desc 'Build the gem.'
task :build do
  sh 'gem build fyi.gemspec'
end

desc 'Build and install the gem locally.'
task :install => :build do
  sh "gem install fyi-#{Fyi::VERSION}.gem"
end

desc 'Tag the code and push tags to origin.'
task :tag do
  sh "git tag v#{Fyi::VERSION}"
  sh "git push origin master --tags"
end

desc 'Publish to rubygems.org.'
task :publish => [:build, :tag] do
  sh "gem push fyi-#{Fyi::VERSION}.gem"
  # sh "git clean -fd"
end
