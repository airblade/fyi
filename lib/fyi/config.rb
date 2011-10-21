require 'yaml'

class Fyi
  class Config

    def notifiers
      config
    end

    private

    def config
      defaults = { 'log' => {} }
      conf = YAML::load(config_file)
      defaults.merge(conf)
    end

    def config_file
      File.read config_file_path
    end

    def config_file_path
      File.join home_dir, '.fyi'
    end

    def home_dir
      ENV['HOME']
    end

  end
end
