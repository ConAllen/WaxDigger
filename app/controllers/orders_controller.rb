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


#this code is available on the stripe API page for charging accounts.
# this line means that amount is equal to the records price, turned into cents and floored to an integer
# the currency will be in euro
# the card will be the form token



    respond_to do |format|
      if @order.save
        format.html { redirect_to root_url, notice: "Thank's for your order with WaxDigger, Come back soon!"}
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
