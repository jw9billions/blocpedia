class ChargesController < ApplicationController
  def create
    # Stripe cutomer object
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # charges object
    charge = Stripe::Charge.create(
       customer: customer.id, # NOT the user_id in my app
       amount: 15_00,
       description: "BigMoney Membership - #{current_user.email}",
       currency: 'usd'
    )

    current_user.premium!
    #current_user.update_attribute(:standard, false)
    #current_user.update_attribute(:premium, true)

    flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: 15_00
    }
  end

=begin

    def downgrade
      current_user = User.find(params[:stripeToken])
      current_user.params[:stripeToken] = nil
      current_user[:customer][:amount] = nil

      if current_user.save
        flash[:notice] = "You stopped the Membership"
        redirect_to new_charge_path
      end
    end

=end

end
