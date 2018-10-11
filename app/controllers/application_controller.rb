class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #默认情况下，帮助函数只能在视图中使用，我们需要在控制器和视图中同时使用帮助函数，需要在控制器中引入帮助函数所在的模块
  include SessionsHelper #引入session控制器的帮助模块
end
