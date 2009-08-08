require 'rubygems'
require 'open4'
require 'fyi/config'
require 'fyi/core_ext'

#
# See /bin/fyi for documentation.
#
class Fyi
  def self.run(command)
    new(command).run
  end

  def initialize(command)
    @command = command
    @config = Config.new
  end

  def run
    # Borrowed from CI Joe.
    out, err, status = '', '', nil
    status = Open4.popen4(@command) do |@pid, stdin, stdout, stderr|
      err, out = stderr.read.strip, stdout.read.strip
    end
    status.exitstatus.to_i == 0 ? run_succeeded(out) : run_failed(out, err)
  rescue Object => e
    run_failed('', e.to_s)
  end

  private

  def run_succeeded output
    notify :success, output
  end

  def run_failed output, error
    notify :failure, output, error
  end

  def notify result, output, error = ''
    notifiers.each do |notifier|
      notifier.notify @command, result, output, error
    end
  end

  # Instantiate and configure notifiers as per the config.
  def notifiers
    @config.notifiers.map do |klass_name, options|
      require "fyi/notifiers/#{klass_name}"
      klass = constantize "Fyi::Notifier::#{klass_name.capitalize}"
      klass.send :new, options
    end
  end

end
