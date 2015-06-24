class WikisController < ApplicationController
  
   def index
     @wikis = policy_scope(Wiki)
   end
  
  def show
    @wiki = Wiki.find(params[:id])
    @user = @wiki.user
  end
  
  def new
    if current_user
      @wiki = Wiki.new
      @id = @wiki.id
      @user = current_user
    end
  end
  
  def create
    @wiki = current_user.wikis.new(params.require(:wiki).permit(:title, :body, :private, :user_id))
    @id = @wiki.id
    @user = current_user
    if @wiki.save
      redirect_to user_path(:id, :user_id), notice: "Wiki was saved successfully."
    else
      flash[:error] = "Error creating wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @user = current_user
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    @user_id = params[:user_id]
    
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private, :user_id))
      @wiki.reload
      flash[:notice] = "Wiki was updated."
      redirect_to user_path(:id, :user_id)
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = current_user.wikis.find(params[:id])
 
    if @wiki.destroy
      flash[:notice] = "Wiki was deleted."
    else
      flash[:error] = "Wiki couldn't be deleted. Try again."
    end
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def select_collaborators
    @wiki = Wiki.find(params[:wiki_id])
    @users = User.all
  end
  
  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end

end
