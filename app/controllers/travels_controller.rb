class TravelsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @travels = @user.travels
    @single_user_travels = true
  end

 
  def show
    @user = User.find(params[:user_id])
    @travels = @user.travels
    @single_user_travels = true
  end


  def new
    @travel = Travel.new
    @current_user
  end

  def edit
    @travel = Travel.find(params[:id])
  end


  def create
    @travel = Travel.new(params[:travel])
    @travel.user_id = @current_user.id
    if @travel.save
      redirect_to travels_path(:user_id => @current_user.id)
    else
      render :new
    end
  end

  # PUT /travels/1
  # PUT /travels/1.json
  def update
    @travel = Travel.find(params[:id])

    respond_to do |format|
      if @travel.update_attributes(params[:travel])
        format.html { redirect_to @travel, notice: 'Travel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @travel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travels/1
  # DELETE /travels/1.json
  def destroy
    @travel = Travel.find(params[:id])
    @travel.destroy

    respond_to do |format|
      format.html { redirect_to travels_url }
      format.json { head :no_content }
    end
  end

  def search
    
  end

  def results
    @travels = @current_user.find_travels(from: params[:from], 
                                          to: params[:to], 
                                          date: params[:date])
  end
end
