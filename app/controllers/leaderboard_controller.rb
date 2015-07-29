class LeaderboardController < ApplicationController
  def index
  
  	@list = Array.new
  	
  	@submissions = Submission.all
  	
  	@submissions.each do |submission| 
  		@list <<   {:id => submission.id, 
  					:score => get_score(submission), 
  					} 
  	end 
  	 	
  	@list = @list.sort_by{|e| -e[:score]}
  	
  	
  end
  
  	def get_score (submission)
  		if (Review.where(submission_id: submission.id).average("score") ) 
      			return Review.where(submission_id: submission.id).average("score").round(2) 
      	else
      			return 0
      	end
      	
	end
end
