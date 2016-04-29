require 'open3'
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
    start_stopwatch
    # Append ";" to command to force Ruby to invoke via shell.
    #
    # Open3.capture3 -> Open3.popen3 -> Process.spawn
    # Process.spawn is similar to Kernel.system
    # Kernel.system is similar to Kernel.exec.
    stdout, stderr, status = Open3.capture3 "#{@command};"
    stop_stopwatch
    status.success? ? run_succeeded(stdout, stderr) : run_failed(stdout, stderr)
  rescue Object => e
    run_failed('', e.to_s)
  end

  private

  def run_succeeded output, error
    notify :success, duration, output, error
  end

  def run_failed output, error
    notify :failure, duration, output, error
  end

  def notify result, duration, output, error = ''
    host = `hostname`.chomp
    notifiers.each do |notifier|
      notifier.notify @command, result, duration, output, error, host
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

  def duration
    @stop - @start
  end

  def start_stopwatch
    @start = Time.now
  end

  def stop_stopwatch
    @stop = Time.now
  end

end
