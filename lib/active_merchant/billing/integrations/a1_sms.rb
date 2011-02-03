module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module A1Sms
        autoload :Notification, File.dirname(__FILE__) + '/a1_sms/notification.rb'

        mattr_accessor :signature_parameter_name
        self.signature_parameter_name = 'sign'


        def self.notification(query_string, options = {})
          Notification.new(query_string, options)
        end
      end
    end
  end
end
