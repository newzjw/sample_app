class User < ApplicationRecord

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

  private #私有方法，只在这个控制器中使用

    def create_remember_token #在创建用户时设置记忆权标
      #加上self后，赋值操作会把值赋值给用户的remember_token，保存用户时，随着其他属性一起存入数据库
      # Create the token.
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
