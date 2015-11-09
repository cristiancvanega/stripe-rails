class ChargesController < ApplicationController

	require 'json'

	before_action :authenticate_user!

	def new
		puts(current_user.enabled)
	end

	def create
	  # Amount in cents
	  amount = 99

	  if !current_user.enabled? then

		  customer = Stripe::Customer.create(
		    :email => current_user.email,
		    :card  => params[:stripeToken]
		  )

		  puts(customer.sources.data);
		  data = customer.sources.data[0]

		  current_user.id_customer = customer.id
		  current_user.enabled = true
		  current_user.last4 = data.last4
		  current_user.brand = data.brand
		  current_user.save

		  charge = Stripe::Charge.create(
		    :customer    => current_user.id_customer,
		    :amount      => amount,
		    :description => 'Register Credit Card',
		    :currency    => 'usd'
		  )

		  Transaction.new(:user_id => current_user.id.to_i, 
		 				 :id_transaction_stripe => charge.id.to_s, 
		 				 :amount => charge.amount.to_i).save
	  end
	  

	rescue Stripe::CardError => e
	  flash[:error] = e.message
	  redirect_to charges_path
	end

	def pay
		charge = Stripe::Charge.create(
		    :customer    => current_user.id_customer,
		    :amount      => params['/pay']['amount'],
		    :description => params['/pay']['description'],
		    :currency    => 'usd'
		  )
		 Transaction.new(:user_id => current_user.id.to_i, 
		 				 :id_transaction_stripe => charge.id.to_s, 
		 				 :amount => charge.amount.to_i,
		 				 :description => params['/pay']['description']).save
		
		render json: charge.status
	end

end
