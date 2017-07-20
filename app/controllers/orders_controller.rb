class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /orders
  # GET /orders.json

#the below link sets up the sales controler. it states the current user is the seller and posts the sales in order of latest sale
def sales
   @orders = Order.all.where(seller: current_user).order("created_at DESC")
 end
#the below link sets up the purchase controler. it states the current user is the buyer and posts the purchases in order of latest sale
def purchases
  @orders = Order.all.where(buyer: current_user).order("created_at DESC")
end

def purchases
  @orders = Order.all.where(buyer: current_user).order("created_at DESC")
end



  # GET /orders/new
  def new
    @order = Order.new
    @record = Record.find(params[:record_id])
  end



  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    @record = Record.find(params[:record_id])
    @seller =@record.user

    @order.record_id = @record.id
    # this tells rails that the buyer id is equal to the current user id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

    #this first line tells stripe the secret key i added earlier from the stripe site and tells what acc to charge

        Stripe.api_key = ENV["STRIPE_API_KEY"]
    # looks in the submitted form data. then pulls out the token stipe has given us, and hides it in the token.
        token = params[:stripeToken]

    #this code is available on the stripe API page for charging accounts.
    # i multiplied the selling price by 100 and use the .floor extension to keep the price in a integer
        begin
          charge = Stripe::Charge.create(
            :amount => (@record.Selling_Price * 100).floor,
            :currency => "eur",
            :card => token
            )
          flash[:notice] = "Thank you for ordering with WaxDigger, Come back soon!"
        rescue Stripe::CardError => e
          flash[:danger] = e.message
        end

        respond_to do |format|
          if @order.save
            format.html { redirect_to root_url}
            format.json { render :show, status: :created, location: @order }
          else
            format.html { render :new }
            format.json { render json: @order.errors, status: :unprocessable_entity }
          end
        end
      end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address, :town_or_city, :state_or_county, :post_or_zip_code, :country)
    end
end
