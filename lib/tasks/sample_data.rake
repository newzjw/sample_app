namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
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
  end
end