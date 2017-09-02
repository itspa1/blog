class Comment < ApplicationRecord
	validates_presence_of :title ,:body
	belongs_to :article
	belongs_to :user
end
