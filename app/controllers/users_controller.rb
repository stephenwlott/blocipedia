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
    if current_user
      @id = current_user.id
      @users = User.all
      @user = @users.find(@id)
      if @user
        @wikis = current_user.wikis
      end
 
      if @user.update_attribute :role, "standard"      
        @wikis.each do |w|
          if w.private
            w.update_attribute :private, false
          end
        end
        @user.reload
        flash[:notice] = "User account downgraded."
        redirect_to @user
      else
        flash[:error] = "There was an error downgrading the user account. Please try again."
        redirect_to @user
      end
    else
      flash[:notice] = "No user signed in."
      render 'welcome/index'
    end
  end  
end