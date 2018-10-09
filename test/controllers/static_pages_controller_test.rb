require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  test "should get root" do
    get root_url
    assert_response :success
  end

  #为了测试首页，向 StaticPages 控制器中 home 动作对应 的 URL 发起 GET 请求，确认得到的是表示成功的响应码。
  test "should get home" do
    get static_pages_home_url    # get 表示测试期望这两 个页面是普通的网页，可以通过 GET 请求访问
    assert_response :success   # :success 响应（表示 200 OK）是对 HTTP 响应码的抽象表示
    assert_select "title", "Home | #{@base_title}" #检查有没有 <title> 标签，以及其中的内容是不是“Home | Ruby on Rails Tutorial Sample App”字符串
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | #{@base_title}"
  end

  test "should get about" do #编写一个失败测试案例
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do #编写一个失败测试案例
    get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

end
