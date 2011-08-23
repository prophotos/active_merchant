module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module A1Lite
        autoload :Notification, File.dirname(__FILE__) + '/a1_lite/notification.rb'
        autoload :Return, File.dirname(__FILE__) + '/a1_lite/return.rb'

        mattr_accessor :signature_parameter_name
        self.signature_parameter_name = 'check'


        def self.notification(query_string, options = {})
          Notification.new(query_string, options)
        end

        def self.return(query_string)
          Return.new(query_string)
        end
      end
    end
  end
end
