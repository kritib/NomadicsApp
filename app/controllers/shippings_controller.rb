class ShippingsController < ApplicationController
  def new
    @shipping = Shipping.new
  end

  def create
    @request = Request.find(params[:request_id])
    @request.mule_id = @current_user.id
    @request.save!
    redirect_to @request
  end
end
