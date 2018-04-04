class HomeController < ApplicationController
  def index
    @user = current_user
    if @user.cart == nil
      Cart.create(user_id: @user.id)
    end
  end
end
