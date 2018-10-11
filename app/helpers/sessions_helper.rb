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

  def sign_out  #退出登录，销毁cookies中的remember_token
    self.current_user = nil
    cookies.delete(:remember_token) #调用cookies的delete方法，删除记忆标权
  end
end
