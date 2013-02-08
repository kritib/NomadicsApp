class SessionsController < ApplicationController

	skip_before_filter :require_login, only: [:index, :new, :create]

	def index
	end

	def new
	end

	def create
		if user = User.find_by_email(params[:email])
			if user.authenticate(params[:password])
				if token = user.reset_token
					session[:token] = token
          flash[:notice] = "You are logged in!"
          redirect_to user_path(user)
          return
        else
          flash[:error] = user.errors.full_messages.to_sentence
        end
      else
        flash[:notice] = "Woah, guy, try again!"
        flash[:error] = "Wrong Password"
      end
    else
      flash[:notice] = "Woah, guy, try again!"
      flash[:error] = "Invalid email address"
    end
    render :new
	end

	def destroy
		@current_user.delete_token
		session[:token] = nil
		@current_user = nil
		redirect_to root_path
	end
end
