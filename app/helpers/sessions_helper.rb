module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token  #创建新标权
    #rails提供的cookies方法，permanent自动把cookies的失效时间设置成20年
    cookies.permanent[:remember_token] = remember_token #把未加密的标权存入浏览器的cookie
    #update_attribute可以跳过数据验证更新单个属性
    user.update_attribute(:remember_token, User.encrypt(remember_token)) #把加密后的标权存入数据库
    self.current_user = user #把定制的用户设为当前登录用户
  end

  #判断是否登录，如果当前用户不为空，则表示有登录状态
  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    #||=(“or equals”),使用这个操作符后，当且仅当@current_user未定义时才会把通过记忆权标获取的用户值赋值给实例变量@current_user,后续调用的时候直接返回@current_user的值，不用再次查询数据库
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)  #判断user是否是当前登录用户
    user == current_user
  end

  #本来是放在usercontroller,因为只有这里用到，可是现在micropost也要用，就把它移动到这
  # Before filters
  def signed_in_user #如果没有登录，跳转到登录页面
    unless signed_in?#等同于下面那行代码
      store_location #调用了store_location方法，把所请求页面的完整地址赋值给session[:return_to]
      flash[:notice] = "Please sign in."
      redirect_to signin_url
    end
    #redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def sign_out  #退出登录，销毁cookies中的remember_token
    self.current_user = nil
    cookies.delete(:remember_token) #调用cookies的delete方法，删除记忆标权
  end


  def redirect_back_or(default) #如果存储了之前的地址，则转向这个地址，否则转向参数中指定的地址
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  def store_location
    #request.fullpath获取所请求页面的完整地址
    session[:return_to] = request.fullpath
  end
end
