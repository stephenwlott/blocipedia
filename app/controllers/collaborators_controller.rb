class CollaboratorsController < ApplicationController
  
  def create
    @user = current_user
    @user_id = params[:user_id]
    @wiki_id = params[:wiki_id]
    @collaborator = Collaborator.create!(:wiki_id => @wiki_id, :user_id => @user_id)
    redirect_to wiki_select_collaborators_path(:wiki_id => @wiki_id, :user_id => @user_id)
  end
 
end