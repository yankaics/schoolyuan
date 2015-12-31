require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User",email: "user@example.com",
            password: "caiyixia",password_confirmation: "caiyixia")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?,"#{valid_address.inspect} should be valid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Hello~,校缘")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

=begin
  test "should follow and unfollow a user" do
    sunkun = users(:sunkun)
    likaifu = users(:likaifu)
     assert_not sunkun.following?(likaifu)
    sunkun.follow(likaifu)
    assert sunkun.following?(likaifu)
    assert likaifu.followers.include?(sunkun)
    sunkun.unfollow(likaifu)
    assert_not sunkun.following?(likaifu)
  end

  test "feed should have the right posts" do
    sunkun = users(:sunkun)
    likaifu = users(:likaifu)
    lana = users(:lana)
    # 关注的用户发布的微博
    lana.microposts.each do |post_following|
      assert sunkun.feed.include?(post_following)
    end
    # 自己的微博
    sunkun.microposts.each do |post_self|
      assert sunkun.feed.include?(post_self)
    end
    # 未关注用户的微博
    likaifu.microposts.each do |post_unfollowed|
      assert_not sunkun.feed.include?(post_unfollowed)
    end
  end
=end
end
