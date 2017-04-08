task :setup_rake => :environment do 
	Role.create(name: "admin")
	Role.create(name: "author")
	Role.create(name: "moderator")
	Role.create(name: "user")

	user = User.new
	user.username = "admin"
	user.gender = "male"
	user.email = "admin@gmail.com"
	user.password = "secret123"
	user.save

	Permission.create(user_id: user.id , role_id: Role.first.id)


end