module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module A1Sms
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def self.recognizes?(params)
            params.has_key?('msg') && params.has_key?('country_id') && params.has_key?('cost_rur')
          end

          def complete?
            status == 'success'
          end

          def transaction_id
            params['smsid']
          end

          def gross
            params['cost_rur']
          end

          def amount
            BigDecimal.new(gross)
          end

          def short_number
            params['num']
          end

          def item_id
            msg = params['msg']
            @options[:prefixes].uniq.each do |prefix|
              if msg.starts_with?(prefix)
                return msg.sub(prefix, '').strip.gsub(/\+/, '')
              end
            end
            return nil
          end

          def received_at
            params['date']
          end

          def phone
            params['user_id']
          end

          def msg_trans
            params['msg_trans']
          end

          def status
            'success'
          end

          def operator_id
            params['operator_id']
          end

          def country_id
            params['country_id']
          end

          def security_key
            params[ActiveMerchant::Billing::Integrations::A1Sms.signature_parameter_name]
          end

          def generate_signature_string
            [received_at, msg_trans, operator_id, phone, transaction_id, gross, params['ran'], params['test'], short_number, country_id, @options[:secret]].flatten.compact.join('')
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
            "smsid: #{transaction_id}\nstatus: reply\n\n#{options[:answer]}"
          end

          def error_response(error_type, options = {})
            "Error: #{options[:answer]}"
          end
        end
      end
    end
  end
end
