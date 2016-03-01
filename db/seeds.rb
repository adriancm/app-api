# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

random = Random.new(1234)
users = []
20.times do | n |
  user = User.new(username: "test#{n}", email: "test#{n}@api-app.com", password: '12345678', password_confirmation: '12345678', first_name: "Name#{n}", last_name: "Last#{n}")
  user.messages.build text: "message test #{n}"
  user.messages.build text: "message test #{n+1}"
  user.skip_confirmation!
  user.save!
  users << user

  n.times do
    m = random.rand(n+1)
    o = random.rand(m+1)
    x = Follow.new(followed_id: users[o].id, follower_id: users[m].id)
    if x.valid?
      x.save
    end
  end
end