25.times do
	article = Article.new
	article.title = Faker::Lorem.unique.sentence
	article.body = Faker::Lorem.paragraph
	article.published = Faker::Boolean.boolean(0.65)
	article.published_date = Faker::Date.unique.between(8.months.ago, Date.today)
	article.save
end