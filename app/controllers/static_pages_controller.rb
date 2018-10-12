class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page]) #获取当前登录用户的所有微博
    end

  end

  def help
  end

  def about
  end

  def contact

  end
end
