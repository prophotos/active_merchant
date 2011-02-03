require 'test_helper'

class A1SmsModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_notification_method
    assert_instance_of A1Sms::Notification, A1Sms.notification('name=cody')
  end
end
