require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'login with valid information' do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', "#{login_path}?locale=#{I18n.locale}", count: 0
    assert_select 'a[href=?]', "#{logout_path}?locale=#{I18n.locale}"
    assert_select 'a[href=?]', "#{user_path(@user)}?locale=#{I18n.locale}"
  end

  test 'login with valid information followed by logout' do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', "#{login_path}?locale=#{I18n.locale}", count: 0
    assert_select 'a[href=?]', "#{logout_path}?locale=#{I18n.locale}"
    assert_select 'a[href=?]', "#{user_path(@user)}?locale=#{I18n.locale}"
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to "#{root_url}?locale=#{I18n.locale}"
    follow_redirect!
    assert_select 'a[href=?]', "#{login_path}?locale=#{I18n.locale}"
    assert_select 'a[href=?]', "#{logout_path}?locale=#{I18n.locale}", count: 0
    assert_select 'a[href=?]', "#{user_path(@user)}?locale=#{I18n.locale}",
                  count: 0
  end
end
