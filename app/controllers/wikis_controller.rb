class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
     #@user = my_user
     @wiki = Wiki.new
  end
  
  def create
     @wiki = Wiki.new(user: current_user)
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.user = current_user
     
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
   end
 
   def update
     @wiki = Wiki.find(params[:id])
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
   #   @wiki = Wiki.find(params[:id])
   #   authorize @wiki
 
    if @wiki.save
       flash[:notice] = "Wiki was updated successfully."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :edit
    end
   end
   
  def destroy
     @wiki = Wiki.find(params[:id])
   #   title = @wiki.title
   #   authorize @wiki
 
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
  end
end
