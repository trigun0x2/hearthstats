class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 999
    begin
      if current_user.customer_id.nil?
        customer = Stripe::Customer.create(
          :email => current_user.email,
          :card  => params[:stripeToken],
          :plan => 'gold'
        )
        current_user.subscription_id = 1
        current_user.customer_id = customer.id
        current_user.save
      end

    rescue Stripe::CardError => e
      redirect_to charges_path, alert: e and return
    end
      redirect_to charges_path, notice: "Thank you for subscribing!" 
  end

  def cancel
    begin
      customer = Stripe::Customer.retrieve(current_user.customer_id)
      unless customer.nil? or customer.respond_to?('deleted')
        subscription = customer.subscriptions.data[0]
        if subscription.status == 'active'
          customer.cancel_subscription
          current_user.subscription_id = nil
          current_user.customer_id = nil
          current_user.save
        end
      end
    rescue Stripe::StripeError => e
      logger.error "Stripe Error: " + e.message
      errors.add :base, "Unable to cancel your subscription. #{e.message}."
      redirect_to charges_path, alert: e and return
    end
      redirect_to charges_path, notice: "Sorry to see you go! :("
  end

  def show
  end
end
