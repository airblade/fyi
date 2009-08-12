require 'logger'

class Fyi
  class Notifier
    # Logs command execution to a file.
    #
    # The log level depends on the execution result: INFO if the
    # command succeeded, WARN if it failed.
    class Log
      attr_reader :logger
      
      # Options you can supply:
      # +file+: full path to a log file.  Defaults to +fyi.log+ in
      # the process's home directory.
      def initialize options
        log_file = options['file'] || default_log_file
        @logger = Logger.new log_file
      end

      def notify command, result, duration, output, error = ''
        logger.log severity(result), message(command, result, duration, output, error)
      end

      private

      def severity result
        result == :success ? Logger::INFO : Logger::WARN
      end

      def message command, result, duration, output, error
        <<END
command: #{command}
duration: #{duration}s
status: #{result.to_s.upcase}
stdout: #{output}
stderr: #{error}
END
      end

      def default_log_file
        File.join home_dir, 'fyi.log'
      end

      def home_dir
        ENV['HOME']
      end
    end
  end
end
