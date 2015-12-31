require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  # 测试微博是否有效
  def setup
    @user = users(:sunkun)
    # 待定
    # @micropost = Micropost.new(content:"Hello~,校缘",user_id: @user.id)
    @micropost = @user.microposts.build(content: "Hello~,校缘")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
  
  test "content should be present" do
    @micropost.content = " "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    assert_equal Micropost.first, microposts(:most_recent)
  end
end
