require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", "#{root_path}?locale=#{I18n.locale}", count: 2
    assert_select "a[href=?]", "#{help_path}?locale=#{I18n.locale}"
    assert_select "a[href=?]", "#{about_path}?locale=#{I18n.locale}"
    assert_select "a[href=?]", "#{contact_path}?locale=#{I18n.locale}"
    get contact_path
  end
end
