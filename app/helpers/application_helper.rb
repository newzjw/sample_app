module ApplicationHelper
  #我们想在所有页面中都使用 full_title 方 法，所以要放在一个特殊的辅助文件中，即 app/helper/application_helper.rb 。
  #如果辅助方法是针对某个特定控制器的，应该把它放进该控制器对应的辅助文件中
  #  自定义函数，根据所在的页面返回完整的标题
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?  #如果没有设置page_title,则只显示base_title,没有|
      base_title
    else
      page_title + " | " + base_title
    end
  end

end
