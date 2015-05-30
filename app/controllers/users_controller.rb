class UsersController < ApplicationController
  
  def show
    @user = current_user
    if @user
      @wikis = current_user.wikis
    end
  end
end