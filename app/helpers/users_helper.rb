module UsersHelper
# Returns the Gravatar (http://gravatar.com/) for the given user.
  #该方法的返回值是gravatar头像的img元素，
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

end
