class ChargesController < ApplicationController
    def new
        @cart = params[:id]
        @purchases = Purchase.where(:cart_id => @cart)

        @total = 0
        @purchases.each do |purchase|
            @total += (purchase.product.unitprice*purchase.quantity)
        end    

    end
    
    def create
      # Amount in cents
      #@amount = 500
    
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
    
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @total*100,#covert to cents
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
    
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
    end
end
