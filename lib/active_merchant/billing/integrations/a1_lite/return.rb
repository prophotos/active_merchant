module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module A1Lite
        class Return < ActiveMerchant::Billing::Integrations::Return
          def item_id
            @params['order_id']
          end

          def amount
            @params['system_income']
          end
	      end
      end
    end
  end
end
