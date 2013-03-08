class UsersController < ApplicationController

  skip_before_filter :require_login, only: [:new, :create]


  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end


  def show
    @user = User.find(params[:id])
    @travels = @user.travels.includes(:from_country, :to_country).all
    @requests = @user.requests.includes(:from_country, :to_country).all
    @single_user_travels = true
    @single_user_requests = true
    @access = has_access?(@user)
    @friend = is_friend?(@user)
  end


  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    photo_io = params[:user].delete(:photo_blob)
    @user = User.new(params[:user])
    @user.photo_blob = photo_io.read unless photo_io.nil?

    if @user.save
      flash[:notice] = "Welcome to Nomadics, #{@user.name}!"
      @current_user = @user
      token = @current_user.reset_token
      session[:token] = token
      # UserMailer.welcome_email(@user).deliver
      redirect_to @user
    else
      flash[:notice] = "Woah, guy, try again!"
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end


  def update
    @user = User.find(params[:id])
    photo_io = params[:user].delete(:photo_blob)
    @user.photo_blob = photo_io.read unless photo_io.nil?
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user)
    else
      render 'edit'
    end

    # @user = User.find(params[:id])
    # @user.update_attribute(params)

  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def photo
    user = User.find(params[:id])
    send_data(user.photo_blob, :type => 'image/jpg', :disposition => 'inline')
  end

  def friends
    @results = @current_user.travelers
  end

  def search
    @results = User.find_users(params[:search_query])
    @friends = @current_user.travelers
    render 'search'
  end


end
