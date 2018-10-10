class User < ApplicationRecord
  before_save { self.email = email.downcase }  #在存入数据库前，把email变成小写，再判断唯一性

  has_secure_password  #只要数据库中有password_digest列，在模型文件中加入这个方法，就能验证用户身份

  validates :name, presence: true, length: { maximum: 10 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  #邮箱格式验证
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
end
