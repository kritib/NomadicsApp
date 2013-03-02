class TravelsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @travels = @user.get_all_travels
    @travel = Travel.new
    @single_user_travels = true
  end


  def show
    @travel = Travel.find(params[:id])
  end


  def new
    @travel = Travel.new
  end

  def edit
    @travel = Travel.find(params[:id])
    render 'travels/_new', :layout => false
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


    elsif params[:from] && params[:to] && params[:date]
      query_hash = {from: params[:from][:id],
                    to: params[:to][:id],
                    "date(1i)" => params[:date][:year],
                    "date(2i)" => params[:date][:month],
                    "date(3i)" => params[:date][:day]}
      p query_hash
      @travels = @current_user.find_friend_travels(query_hash)
    end
  end

  def results
    query_hash = {from: params[:from],
                  to: params[:to],
                  "date(1i)" => params[:date][:year],
                  "date(2i)" => params[:date][:month],
                  "date(3i)" => params[:date][:day]}
    @travels = @current_user.find_travels(query_hash)
  end
end




