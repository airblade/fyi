begin
  require 'pony'
rescue LoadError
  abort '** Please install pony.'
end

class Fyi
  class Notifier
    # Emails the results of command execution via SMTP.
    #
    # By default only failures are emailed.
    class Email

      # Options you may supply:
      #
      # +from+: the from address
      # +to+: the to address
      # +on_success+: whether to notify when the command succeeded.
      #   Optional.  Defaults to false.
      # +on_failure+: whether to notify when the command failed.
      #   Optional.  Defaults to true.
      # +smtp+: you should supply SMTP config options under this key.
      #
      # SMTP config options are:
      # +host+
      # +port+
      # +user+
      # +password+
      # +auth+
      # +domain+
      def initialize options
        @from = options['from']
        @to   = options['to']
        @smtp = symbolize_keys options['smtp']
        @on_success = options['on_success']
        # Notify of failures by default.
        @on_failure = options.has_key?('on_failure') ? options['on_failure'] : true
      end

      def notify command, result, duration, output, error = '', host = ''
        send_email(command, result, duration, output, error, host) if should_notify?(result)
      end

      private

      def should_notify?(result)
        (result == :success && @on_success) || (result == :failure && @on_failure)
      end

      def send_email command, result, duration, output, error, host
        Pony.mail :to          => @to,
                  :from        => @from,
                  :subject     => subject(command, result),
                  :body        => body(command, duration, output, error, host),
                  :via         => :smtp,
                  :via_options => @smtp
      end

      def subject command, result
        "[#{result.to_s.upcase}] #{truncate command}"
      end

      def body command, duration, output, error, host
        <<END
host: #{host}

command: #{command}

duration: #{duration}s

stdout: #{output}

stderr: #{error}
END
      end

      def truncate string, length = 30
        if string.length > length
          "#{string[0..(length - 3)]}..."
        else
          string
        end
      end

      def symbolize_keys hsh
        hsh.inject({}) { |h,(k,v)| h[k.to_sym] = v; h }
      end

    end
  end
end
