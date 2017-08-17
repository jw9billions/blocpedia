class UsersController < ApplicationController
  def downgrade
    current_user.standard!
    redirect_to wikis_path, notice: 'You have been downgraded'
  end
end
