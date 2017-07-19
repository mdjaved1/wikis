class WikisController < ApplicationController
   def index
     @wikis = policy_scope(Wiki)
   end

  def show
    @wiki = Wiki.find(params[:id])
     unless (@wiki.private == false) || current_user.premium? || current_user.admin?
         flash[:alert] = "You must be a premium user to view private topics."
         if current_user
           redirect_to new_charge_path
         else
           redirect_to new_user_registration_path
         end
     end
  end

  def new
     #@user = my_user
     @wiki = Wiki.new
     authorize @wiki
  end
  
  def create
     @wiki = Wiki.new(user: current_user)
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private]
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
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
   #   @wiki = Wiki.find(params[:id])
     authorize @wiki
 
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
     authorize @wiki
   #   title = @wiki.title
 
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
  end
end
