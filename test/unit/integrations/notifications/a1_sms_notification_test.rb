require 'test_helper'

class A1SmsNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def test_accessors
    @notification = A1Sms.notification(http_raw_data, config)
    assert @notification.complete?
    assert_equal "success", @notification.status
    assert_equal "5094", @notification.transaction_id
    assert_equal "1234", @notification.item_id
    assert_equal "0.54", @notification.gross
    assert_equal 0.54, @notification.amount
    assert_equal "2008-03-28 17:13:33", @notification.received_at
  end

  def test_another_prefix
    @notification = A1Sms.notification(http_raw_data('1234+7648'), config)
    assert_equal "7648", @notification.item_id
  end

  def test_prefix_without_plus
    @notification = A1Sms.notification(http_raw_data('12347648'), config)
    assert_equal "7648", @notification.item_id
  end

  def test_unknown_prefix
    @notification = A1Sms.notification(http_raw_data('98765 7648'), config)
    assert_equal nil, @notification.item_id
  end

  def test_acknowledgement
    @notification = A1Sms.notification(http_raw_data, config)
    assert @notification.acknowledge
  end

  def test_respond_to_acknowledge
    @notification = A1Sms.notification(http_raw_data, config)
    assert @notification.respond_to?(:acknowledge)
  end

  def test_signature_string
    @notification = A1Sms.notification(http_raw_data, config)
    assert_equal '2008-03-28 17:13:3377777 12341207909908037550940.5471112145909secret', @notification.generate_signature_string
  end

  private
  def config
    {:secret => 'secret', :prefixes => ["77777", "1234"]}
  end

  def http_raw_data(msg = '77777+1234')
    "date=2008-03-28+17%3A13%3A33&msg=#{msg}&msg_trans=#{msg}&operator_id=120&country_id=45909&user_id=79099080375&smsid=5094&cost=0.015&cost_rur=0.54&test=1&num=1121&retry=1&try=2&ran=7&skey=098f6bcd4621d373cade4e832627b4f6&sign=d1d9dd7d8f38b549b22f0ddaf22a3861"
  end
end
