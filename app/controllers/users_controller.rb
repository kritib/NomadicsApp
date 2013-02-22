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
      flash[:notice] = "Welcome to FriendMule, #{@user.name}!"
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
    @friends = @current_user.travelers
  end


end
