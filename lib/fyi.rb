begin
  require 'systemu'
rescue LoadError
  abort '** Please install systemu.'
end

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
    status, stdout, stderr = systemu @command
    status.exitstatus.to_i == 0 ? run_succeeded(stdout) : run_failed(stdout, stderr)
  rescue Object => e
    run_failed('', e.to_s)
  end

  private

  def run_succeeded output
    stop_stopwatch
    notify :success, duration, output
  end

  def run_failed output, error
    stop_stopwatch
    notify :failure, duration, output, error
  end

  def notify result, duration, output, error = ''
    host = `hostname`
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
