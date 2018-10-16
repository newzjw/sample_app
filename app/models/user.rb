class User < ApplicationRecord
  has_many :microposts, dependent: :destroy #保证在删除某个用户的情况下，该用户的所有微博同步删除
  #用户和关系表的关系
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #source告知rails，followed_users数组来源是followed所代表的id集合
  has_many :followed_users, through: :relationships, source: :followed

  #粉丝
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name: "Relationship",
           dependent: :destroy
  # 这里source可以省略
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { self.email = email.downcase }  #在存入数据库前，把email变成小写，再判断唯一性
  before_create :create_remember_token #在创建用户时设置记忆权标

  has_secure_password  #只要数据库中有password_digest列，在模型文件中加入这个方法，就能验证用户身份

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  #邮箱格式验证
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def User.new_remember_token #获取64位随机数
    SecureRandom.urlsafe_base64
  end
  def User.encrypt(token)  #给传入的token值加密
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    #Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end


  #判断是否关注了某个用户
  def following?(other_user)
    #self可以省略
    self.relationships.find_by(followed_id: other_user.id)
  end

  #关注用户
  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end
  #取消关注
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  private #私有方法，只在这个控制器中使用

    def create_remember_token #在创建用户时设置记忆权标
      #加上self后，赋值操作会把值赋值给用户的remember_token，保存用户时，随着其他属性一起存入数据库
      # Create the token.
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
