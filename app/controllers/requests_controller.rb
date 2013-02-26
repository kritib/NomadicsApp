class RequestsController < ApplicationController

	def index
    @user = User.find(params[:user_id])
    @requests = @user.requests
    @single_user_requests = true
  end

	def new
		@request = Request.new
	end


	def create
		@request = Request.new(params[:request])
    @request.requester_id = @current_user.id
    if @request.save
      redirect_to requests_path(:user_id => @current_user.id)
    else
      render :new
    end
	end

	def show
    @user = User.find(params[:user_id])
    @requests = @user.requests
    @single_user_requests = true
  end
end
