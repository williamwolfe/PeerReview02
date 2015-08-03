class ReviewsController < ApplicationController
before_action :authenticate_user!
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    #@reviews = Review.all
    @submission = Submission.find_by user_id:current_user.id
    if(@submission)
    	@reviews = Review.where("submission_id = '" + @submission.id.to_s + "'")
    	#@average = @reviews
    end
	
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
  	@submission_id = params[:submission_id]
  	@submitted = Submission.find(@submission_id)
  	if(@submitted.user_id == current_user.id)
  		flash[:notice] = "Cannot review yourself, pick someone else"
    	redirect_to submissions_path and return		
  	end
  	 	
  	if (Review.find_by user_id:current_user.id, submission_id:@submission_id)
  		flash[:notice] = "You already reviewed this work"
  		redirect_to submissions_path and return
  	end
  	
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:submission_id, :user_id, :comment, :score)
    end
end
