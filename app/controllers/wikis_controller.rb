class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
    @user = @wiki.user
  end

  def new
    @wiki = Wiki.new
    @user = current_user
  end
  
  def create
    @wiki = current_user.wikis.new(params.require(:wiki).permit(:title, :body))
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
    @user = @wiki.user
    
    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      @wiki.reload
      flash[:notice] = "Wiki was updated."
      redirect_to @user
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
  
  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end
  
end
