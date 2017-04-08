task :setup_rake => :environment do 

	25.times do
	article = Article.new
	article.title = Faker::Lorem.unique.sentence
	article.body = Faker::Lorem.paragraph
	article.published = Faker::Boolean.boolean(0.65)
	article.published_date = Faker::Date.unique.between(8.months.ago, Date.today)
	article.save
	end

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