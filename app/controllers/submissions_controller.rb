class SubmissionsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_submission, only: [:show, :edit, :update, :destroy]
	
	def index
    	@submissions = Submission.all
    	
    	@has_submitted =  @submissions.find_by user_id:current_user.id
    	if(@has_submitted)
    		@submission_id = @has_submitted.id
    	end
  	end
	
	def show
    	@submission = Submission.find(params[:id])   	
    	@review = Review.find_by submission_id:@submission.id, user_id:current_user.id
  	end
  
	def new	
		@already_submitted = Submission.find_by user_id:current_user.id
		if(@already_submitted)
  			flash[:notice] = "Only one submission per user"
    		redirect_to submissions_path		
  		end		
	end
	
	def edit
	
		@submission_id = Submission.find_by user_id:current_user.id
		@submission = Submission.find(@submission_id)
	
	end
	
	def create 		
  		@submission = Submission.new(params.require(:submission).permit(:title, :description, :link, :user_id))
		@submission.user_id = current_user.id;
  		@submission.save
  		redirect_to @submission
	end
	
	# PATCH/PUT /submissions/1
  	# PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end
	
	private
	
	 def set_submission
      @submission = Submission.find(params[:id])
    end
    
  		def submission_params
    		params.require(:submission).permit(:title, :description, :link, :user_id)
  		end
end
