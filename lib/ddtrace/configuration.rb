require 'ddtrace/configuration/pin_setup'
require 'ddtrace/configuration/settings'

module Datadog
  # Configuration provides a unique access point for configurations
  module Configuration
    attr_writer :configuration

    def configuration
      @configuration ||= Settings.new
    end

    def configure(target = configuration, opts = {})
      if target.is_a?(Settings)
        yield(target) if block_given?
      else
        PinSetup.new(target, opts).call
      end
    end

    # Helper methods
    def tracer
      configuration.tracer
    end

    def runtime_metrics
      if tracer.writer.respond_to?(:runtime_metrics)
        tracer.writer.runtime_metrics
      else
        @runtime_metrics ||= Runtime::Metrics.new
      end
    end
  end
end
