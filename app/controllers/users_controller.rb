class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create

    # params中是个嵌套的hash，我们使用其中的user
    @user = User.new(user_params) # Not the final implementation!
    if @user.save
      sign_in @user #用户注册的同时，登录
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user  #转向用户资料页面
    else
      render 'new'
    end
  end





  private #私有方法，只在这个控制器中使用
    def user_params #只允许传入这几个属性，返回一个param hash
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end


end
