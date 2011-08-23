module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module A1Lite
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def self.recognizes?(params)
            params.has_key?('tid') && params.has_key?('partner_id') && params.has_key?('service_id') && params.has_key?('order_id')
          end

          def complete?
            status == 'success'
          end

          def transaction_id
            params['tid']
          end

          def gross
            params['system_income']
          end

          def amount
            BigDecimal.new(gross)
          end

          def item_id
            params['order_id']
          end

          def name
            params['name']
          end

          def comment
            params['comment']
          end

          def partner_id
            params['partner_id']
          end

          def service_id
            params['service_id']
          end

          def currency
            params['type']
          end

          def status
            'success'
          end

          def security_key
            params[ActiveMerchant::Billing::Integrations::A1Lite.signature_parameter_name]
          end

          def generate_signature_string
            [transaction_id, name, comment, partner_id, service_id, item_id, currency, params['partner_income'], params['system_income'], @options[:secret]].flatten.compact.join('')
          end

          def generate_signature
            Digest::MD5.hexdigest(generate_signature_string)
          end

          def acknowledge
            security_key == generate_signature
          end

          def response_content_type
            'text/plain'
          end

          def success_response(options = {}, *args)
            "OK"
          end

          def error_response(error_type, options = {})
            "ERROR"
          end
        end
      end
    end
  end
end
