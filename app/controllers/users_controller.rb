class UsersController < ApplicationController
  
  
  def show
    @user = current_user
    @user_posts = @user.posts
  end
  
end
