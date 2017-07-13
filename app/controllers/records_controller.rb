class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
#the code below is a devise filter so that only authenticated users can create, edit, update or destroy a listing.
  before_action :authenticate_user!, only:[:seller, :new, :create, :edit, :update,:destroy]
  before_action :check_user, only:[:edit, :update, :destroy]

#the below method was set up for a seller action.so when a user wants to go to the seller page. they only see their records.
#the records are then ordered by latest uploads
 def seller
  @records = Record.where(user: current_user).order("created_at DESC")
  end

  # GET /records
  # GET /records.json
  def index
    @records = Record.all.order("created_at DESC")
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)
#the below code tells rails that the new record user id is equal to the current user. it adds association
    @record.user_id = current_user.id

    respond_to do |format|
      if check_max_price && @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @record }
        flash[:notice] = "Successfully created..."
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
        flash[:notice] = "There was a problem, the record must be less then a 50% surcharge of origial price"
      end
    end
  end

  def check_max_price
    return true if @record.Selling_Price < @record.max_price
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:Title, :Label, :Format, :Country, :Released, :Genre, :Tracklist, :Condition, :Original_Price, :Selling_Price, :image)
    end

#the below method checks if the record belongs to the current user. If they try delete or edit the record listing. It redirects them to an alert message.
  def check_user
     if current_user != @record.user
       redirect_to root_url, alert: "Sorry, this Record belongs to someone else"
     end
   end
end
