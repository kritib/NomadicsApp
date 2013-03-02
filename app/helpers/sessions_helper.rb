module SessionsHelper

  def friend_travels
    @current_user.all_friend_travels
  end

  def friend_mule_requests
    @current_user.all_friend_mule_requests
  end
end
