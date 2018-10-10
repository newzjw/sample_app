class User
  #为用户的name和email创建了属性访问器，也就是定义了获取getter和设定setter方法,用来取回和赋值@name和@email实例变量
  #实例变量的作用：在ruby类的不同方法中传递变量值，在rails里的作用：可以在视图直接使用
  attr_accessor :name, :email


  #当执行User.new时会调用该方法
  def initialize(attributes={})
    @name = attributes[:name]
    @email = attributes[:email]
  end

  #因为@name和@email是实例变量，所以他们在formatted_email方法中自动可见
  def formatted_email
    "#{@name} <#{@email}>"
  end


end