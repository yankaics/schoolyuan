require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
=begin
  test "account_activation" do
    user = users(:sunkun)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal "账号激活", mail.subject
    assert_equal [user.email], mail.to 
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,  mail.body.encoded
    assert_match user.activation_token, mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end
=end
end
