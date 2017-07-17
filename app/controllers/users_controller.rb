class UsersController < ApplicationController

  def downgrade
    @user = User.find(params[:id])
    if @user.standard!
      current_user.wikis.update_all(private: false)
      # current_user.wikis.each { |wiki| wiki.update(private: false) }
      flash[:notice] = "You've been downgraded to standard. Your private wikis are now public."
    else
      flash[:error] = "There was an error downgrading your account. Please try again."
    end

    redirect_to :back
  end


  def index
    @users = User.all
  end

  def show
  end
end
