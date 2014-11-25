# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


=begin
User.create({firstname: "John", lastname: "Doe", email: "test1@example.com", username: "user1", password: "password", reset_token: nil, balanced_href: "/customers/CU4B92X0TKF0WwhWi1cZ5oYM"})
User.create({firstname: "Jane", lastname: "Doe", email: "test2@example.com", username: "user2", password: "password", reset_token: nil, balanced_href: "/customers/CU1qeYBwmtwt2CkSSYlvcDUF"})
User.create({firstname: "Joe", lastname: "Testa", email: "test3@example.com", username: "user3", password: "password", reset_token: nil, balanced_href: "/customers/CU75qw3AWTTDg1qpohCeSttr"})
User.create({firstname: "David", lastname: "Gudeman", email: "test4@example.com", username: "user4", password: "password", reset_token: nil, balanced_href: "/customers/CU7diy6Z2hLxuXcRAWhfGTzG"})

Card.create({user_id: 1, balanced_href: "/cards/CC2zyCoyspIkgs6UM8SOHiwR"})
Bank.create({user_id: 1, balanced_href: "/bank_accounts/BA79EHU02TuYnSLtccoq37bO"})
Card.create({user_id: 2, balanced_href: "/cards/CC2pjzoHgPGNwNP8p6lrDq05"})
Bank.create({user_id: 3, balanced_href: "/bank_accounts/BA2jIqE5tPBDGfObxHwkXMl2"})
=end

#Card.create({user_id: 1, balanced_href: "/cards/CC42fgUyS4NAp2h9djyBLYPz"})
#Bank.create({user_id: 2, balanced_href: "/bank_accounts/BA5zymp3oV4Wwz6xk6RWoWzz"})

User.create({firstname: "John", lastname: "Doe", email: "test1@example.com", username: "user1", password: "password", reset_token: nil, balanced_href: ""})
User.create({firstname: "Jane", lastname: "Doe", email: "test2@example.com", username: "user2", password: "password", reset_token: nil, balanced_href: ""})
User.create({firstname: "Joe", lastname: "Testa", email: "test3@example.com", username: "user3", password: "password", reset_token: nil, balanced_href: ""})
User.create({firstname: "David", lastname: "Gudeman", email: "test4@example.com", username: "user4", password: "password", reset_token: nil, balanced_href: ""})






# Photo.create({title: "test1", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 1})
# Photo.create({title: "test2", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 2})
# Photo.create({title: "test3", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 3})
# Photo.create({title: "test4", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 4})
# Photo.create({title: "test5", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 1})
# Photo.create({title: "test6", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 2})
# Photo.create({title: "test7", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 3})
# Photo.create({title: "test8", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 4})
# Photo.create({title: "test9", width: 800 , height: 400, url: "http://lorempixel.com/800/400/city/", price: 250, user_id: 4})





Category.create({name: "Portrait"})
Category.create({name: "Black and White"})
Category.create({name: "Landscape"})
Category.create({name: "Abstract"})


# cate = Category.find(1)
# cate.photos << Photo.all


#Alternative

# User.delete_all
# 100.times do
# 	fname = Faker::Name.first_name
# 	lname = Faker::Name.last_name
# 	User.create(
# 		firstname: fname,
# 		lastname: lname,
# 		username: "#{fname}.#{lname}",
# 		password: "password",
# 		password_confirmation: "password",
# 		email: "#{fname}.#{lname}@gmail.com"
# 	) 
# 	# create(:user)
# end