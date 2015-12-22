require 'test_helper'
  # 用户资料页面的测试
class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
 
  def setup
    @user = users(:sunkun)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', hext: @user.name
    assert_select 'h1>img.gravatar' # 在h1标签中查找类为gravatar的img标签
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
  
end
