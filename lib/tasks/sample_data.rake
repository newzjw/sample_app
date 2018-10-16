namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #创建用户
    User.create!(name: "zjw",
                 email: "zjw@qq.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name = Faker::Name.name
      email = "zjw#{n+1}@qq.com"
      password = "111111"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    #创建微博
    users = User.all.take(5)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
    #创建关注和被关注
    users = User.all
    user = users.first
    followed_users = users[2..50]
    followers = users[3..40]
    followed_users.each { |followed| user.follow!(followed) }
    followers.each { |follower| follower.follow!(user) }
  end




end