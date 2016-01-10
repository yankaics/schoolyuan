# 向数据库中添加示例用户

# 用户
User.create!(name: "孙琨",
     email: "sunkun201309@163.com",
     password:  "caiyicai",
     password_confirmation: "caiyicai",
     admin: true,
     activated: true,
     activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@163.com"
  password = "password"
  gender="男"
  if n%3
    gender="女"
  end
  age=n%30+15
  height=n%30+150
  married=false
  if n%5
    married=true
  end
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               gender: gender,
               age: age,
               height: height,
               married_info: married,
               activated: true,
               activated_at: Time.zone.now)
end

# 微博
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# 关注关系
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
