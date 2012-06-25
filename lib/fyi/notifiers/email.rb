require 'mail'

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
      # SMTP config options are whatever Mail takes.
      # https://github.com/mikel/mail/blob/master/lib/mail/network/delivery_methods/smtp.rb
      def initialize options
        @from = options['from']
        @to   = options['to']
        @on_success = options['on_success']
        # Notify of failures by default.
        @on_failure = options.has_key?('on_failure') ? options['on_failure'] : true

        smtp = symbolize_keys(options['smtp'])
        Mail.defaults do
          delivery_method :smtp, smtp
        end
      end

      def notify command, result, duration, output, error = '', host = ''
        send_email(command, result, duration, output, error, host) if should_notify?(result)
      end

      private

      def should_notify?(result)
        (result == :success && @on_success) || (result == :failure && @on_failure)
      end

      def send_email command, result, duration, output, error, host
        _subject = subject(command, result)
        _body    = body(command, duration, output, error, host)
        _to      = @to
        _from    = @from

        Mail.deliver do
          to      _to
          from    _from
          subject _subject
          body    _body
        end
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
