class Submission < ActiveRecord::Base

	validates :title, presence: true
	validates :link, presence: true
end
