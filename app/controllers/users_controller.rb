class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update] #在编辑和更新、显示所有用户的时候，必须判断是否登录
  before_action :correct_user, only: [:edit, :update] #不能编辑其他用户的资料
  before_action :admin_user, only: :destroy   #只有管理员才能删除用户

  def index
    @users = User.paginate(page: params[:page])
  end
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


  def edit #展示编辑页面
    #@user = User.find(params[:id]) 有了before_action :correct_user，这行代码就可以省略了
  end

  def update #编辑用户信息
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params) #这里使用了健壮参数
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy   #找到用户并删除
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  private #私有方法，只在这个控制器中使用
    def user_params #只允许传入这几个属性，返回一个param hash
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    # Before filters
    def signed_in_user #如果没有登录，跳转到登录页面
      unless signed_in?#等同于下面那行代码
        store_location #调用了store_location方法，把所请求页面的完整地址赋值给session[:return_to]
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
      #redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user #判断是否是当前登录用户
      @user = User.find(params[:id]) #根据参数中的id获取user信息
      redirect_to root_path,notice: "你不能编辑其他用户的信息" unless current_user?(@user)  #如果不是当前登录用户，则跳回到首页
    end

    def admin_user  #如果不是管理员用户，则跳到首页
      redirect_to(root_path) unless current_user.admin?
    end

end
