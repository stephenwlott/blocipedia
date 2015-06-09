class UsersController < ApplicationController
  
  def show
    @user = current_user
    if @user
      @wikis = current_user.wikis
    end
  end
  
  def upgrade
    @id = current_user.id
    @users = User.all
    @user = @users.find(@id)
    #@role = "premium"
    #@user_id = current_user.id
    if @user.update_attribute :role, "premium"
      @user.reload
      flash[:notice] = "User account upgraded."
      redirect_to @user
    else
      flash[:error] = "There was an error upgrading the user account. Please try again."
      redirect_to @user
    end
  end
  
  def downgrade
    @id = current_user.id
    @users = User.all
    @user = @users.find(@id)
    
    if @user.role == "standard"
      flash[:notice] = "You are already Standard. Downgrade is not possible."
      render 'users/show'
    else
      if @user.update_attribute :role, "standard"
        @user.reload
        flash[:notice] = "User account downgraded."
        redirect_to @user
      else
        flash[:error] = "There was an error downgrading the user account. Please try again."
        redirect_to @user
      end
    end
  end  
end