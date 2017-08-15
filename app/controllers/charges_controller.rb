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
       amount: Amount.default,
       description: "BigMoney Membership - #{current_user.email}",
       currency: 'usd'
    )

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
      amount: Amount.default
    }
  end

end
