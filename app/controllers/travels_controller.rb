class TravelsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    case params[:order_by]
    when "origin"
      @travels = @user.travels_by_origin
    when "destination"
      @travels = @user.travels_by_destination
    when "travel-date"
      @travels = @user.travels_by_travel_date
    when "date-added"
      @travels = @user.travels_by_updated
    else
      @travels = @user.travels
    end
    @single_user_travels = true
    render 'travels/_travel_table', :layout => false
  end


  def show
    @travel = Travel.find(params[:id])
    @comments = @travel.comments
  end


  def new
    @travel = Travel.new
    @travels = @current_user.travels_by_updated
    @single_user_travels = true
  end

  def edit
    @travel = Travel.find(params[:id])
    render 'travels/_form', :layout => false
  end


  def create
    @travel = Travel.new(params[:travel])
    @travel.user_id = @current_user.id
    @travels = @current_user.travels.order("updated_at DESC")
    @single_user_travels = true
    if @travel.save
      redirect_to new_travel_path
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
      format.html { redirect_to travels_path(:user_id => @current_user.id) }
      format.json { head :no_content }
    end
  end

  def search
    if params[:request_id]
      @request = Request.find(params[:request_id])
      query_hash = {from: @request.from,
                    to: @request.to,
                    date: @request.date}

      @travels = @current_user.find_friend_travels(query_hash)
      @from = Country.find(@request.from)
      @to = Country.find(@request.to)
      @time_diff = true

    elsif params[:from] && params[:to] && params[:date]
      query_hash = {from: params[:from][:id],
                    to: params[:to][:id],
                    date: Date.parse("#{params[:date][:year]}-#{params[:date][:month]}-#{params[:date][:day]}")}
      @travels = @current_user.find_friend_travels(query_hash)
      @from = Country.find(params[:from][:id])
      @to = Country.find(params[:to][:id])
      @time_diff = true
    end
  end
end




