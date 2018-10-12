class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = [] #如果创建微博失败，设置@feed_items为空数组，不然的话会报错undefined method `any?' for nil:NilClass
      render 'static_pages/home'
    end
  end

  def destroy #删除微博
    @micropost.destroy
    redirect_to root_url
  end


  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user #检查当前用户是否发布了制定id的微博
    @micropost = current_user.microposts.find_by(id: params[:id]) #这里如果有find，找不到的时候会抛出异常
    redirect_to root_url if @micropost.nil?
  end
end