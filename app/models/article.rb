class Article < ApplicationRecord

	has_many :comments
	mount_uploader :cover , CoverUploader

	has_many :article_categories
	has_many :categories, through: :article_categories

	validates_presence_of :title , :body , :published_date
	validates_length_of :body, minimum: 10
	validate :check_published_date
	validate :check_published
	belongs_to :user

	private

	def check_published_date
		if self.published_date != nil #can use 'unless' also
			if self.published_date > Date.today + 1.month
				errors.add(:published_date, " can not be greater than 1 month")
			end
		end
	end

	def check_published
		if self.published_date != nil
			if self.published_date <= Date.today and self.published == false
				errors.add(:published_date, " is lesser than today but published is not check marked")
			end
		end	
	end
		
end
