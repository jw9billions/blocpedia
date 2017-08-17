class UsersController < ApplicationController
  def downgrade
    current_user.params[:stripeToken] = nil
    current_user.role = 'standard'
    redirect_to 'wikis#index'
  end
end
