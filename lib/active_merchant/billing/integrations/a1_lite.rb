module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module A1Lite
        autoload :Notification, File.dirname(__FILE__) + '/a1_lite/notification.rb'

        mattr_accessor :signature_parameter_name
        self.signature_parameter_name = 'check'


        def self.notification(query_string, options = {})
          Notification.new(query_string, options)
        end
      end
    end
  end
end
