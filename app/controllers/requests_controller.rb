class RequestsController < ApplicationController

	def index
    @user = User.find(params[:user_id])
    @request = Request.new
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
    @request = Request.find(params[:id])
  end

  def edit
    @request = Request.find(params[:id])
    render 'requests/_new', :layout => false
  end

  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to requests_path(:user_id => @current_user.id) }
      format.json { head :no_content }
    end
  end
end
