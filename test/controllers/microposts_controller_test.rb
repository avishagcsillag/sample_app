require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
  	@user = users(:michael)
    @micropost = microposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should render home if posting comment fails" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_no_difference 'Micropost.count' do
      	post microposts_path, params: { micropost: { content: "" } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
  end

end
