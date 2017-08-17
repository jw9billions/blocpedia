class UsersController < ApplicationController
  def downgrade
    current_user.params[:stripeToken] = nil
    current_user.role = 'standard'
  end
end
