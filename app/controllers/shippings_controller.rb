class ShippingsController < ApplicationController
  def new
    @shipping = Shipping.new
  end

  def create
    @shipping.create!()
  end
end
