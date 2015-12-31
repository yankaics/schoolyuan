require 'test_helper'

# 微博控制器的访问限制测试

class MicropostsControllerTest < ActionController::TestCase

  def setup
    @micropost = microposts(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post :create, micropost: { content: "Hello~,校缘" }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: @micropost
    end
    assert_redirected_to login_url
  end  

  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:sunkun))
    micropost = microposts(:ants)
    assert_no_difference 'Micropost.count' do
      delete :destroy, id: micropost
    end
    assert_redirected_to root_url
  end
end
