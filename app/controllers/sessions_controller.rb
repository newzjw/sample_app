class SessionsController < ApplicationController


  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase) #根据输入的邮箱找用户
    #authenticate是has_secure_password提供的方法，可以验证用户
    if user && user.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in user #调用登录方法
      redirect_to user
    else
      # Create an error message and re-render the signin form.
      #这里应该要用now方法，不然这个错误信息会停留比较久，点另一个页面的时候还在
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy #退出登录功能
    sign_out
    redirect_to root_path

  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end




end
