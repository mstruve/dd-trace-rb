require 'ddtrace/contrib/integration'
require 'ddtrace/contrib/rest_client/configuration/settings'
require 'ddtrace/contrib/rest_client/patcher'

module Datadog
  module Contrib
    module RestClient
      # Description of RestClient integration
      class Integration
        include Contrib::Integration
        register_as :rest_client

        def self.version
          Gem.loaded_specs['rest-client'] && Gem.loaded_specs['rest-client'].version
        end

        def self.loaded?
          defined?(::RestClient::Request)
        end

        def self.compatible?
          super && version >= Gem::Version.new('1.8')
        end

        def default_configuration
          Configuration::Settings.new
        end

        def patcher
          Patcher
        end
      end
    end
  end
end
