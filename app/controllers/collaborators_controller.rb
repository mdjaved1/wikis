class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    collabo = Collaborator.new(user_id: params[:user_id], wiki_id: params[:wiki_id])
    if collabo.save
      redirect_to wiki_path(@wiki), notice: 'Collaborator added'
    else
      redirect_to edit_wiki_path(@wiki), alert: 'There was an error, please try again'
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find(params[:user_id])
    collaborator = Collaborator.find_by(wiki_id: @wiki.id, user_id: @user.id)
    if collaborator.destroy
      redirect_to wiki_path(@wiki), notice: 'Collaborator removed'
    else
      redirect_to edit_wiki_path(@wiki), alert: 'There was an error, please try again'
    end
  end

end
