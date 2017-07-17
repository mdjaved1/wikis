class WikisController < ApplicationController
  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
     @wiki = Wiki.new
     authorize @wiki
  end

  def create
     @wiki = current_user.wikis.new(wiki_params)
     authorize @wiki
     if @wiki.save
       flash[:notice] = "Post was saved successfully."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :new
     end
  end

   def edit
     @wiki = Wiki.find(params[:id])
     authorize @wiki
   end

   def update
     @wiki = Wiki.find(params[:id])
     authorize @wiki

    if @wiki.update(wiki_params)
       flash[:notice] = "Wiki was updated successfully."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :edit
    end
   end

  def destroy
     @wiki = Wiki.find(params[:id])
     authorize @wiki

     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
  end

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
