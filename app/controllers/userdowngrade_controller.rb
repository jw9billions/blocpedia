class UsersController < ApplicationController
  def downgrade
    current_user.standard!
    current_user.wikis.each do |w|
      w.private = false
    end

    redirect_to user_path(current_user)
    flash[:notice] = 'You have been downgraded'
  end
end
