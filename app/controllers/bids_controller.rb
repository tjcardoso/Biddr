class BidsController < ApplicationController
  # before_action :set_bid, only: [:show, :edit, :update]
  before_action :authenticate_user!
  # before_action :authorize_user!
  # before_action :find_auction
  # GET /bids
  # GET /bids.json

  # before_action :find_auction
  # before_action :find_and_authorize_bid, only: :destroy

  # include QuestionsBidsHelper
  # helper_method :user_like

  def create
    @auction      = Auction.find params[:auction_id]
    bid_params    = params.require(:bid).permit(:amount)
    @bid          = Bid.new bid_params
    @bid.auction  = @auction
    @bid.user     = current_user
    # binding.pry
    if current_user == @auction.user
      redirect_to auction_path(@auction), alert: "You can't bid on your own item"
    end
    respond_to do |format|
      if @bid.save
        # BidsMailer.notify_auction_owner(@bid).deliver_later
        format.html { redirect_to auction_path(@auction), notice: "Bid Received!" }
        format.js { render :create_success }
      else
        flash[:alert] = "not saved"
        # this will render the show.html.erb inside views/auctions
        format.html { render "/auctions/show" }
        format.js { render :create_failure }
      end
    end

  end

  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to auction_path(@auction), notice: "Bid deleted!" }
      format.js { render }
    end
  end

  def edit
    @bid = Bid.find params[:id]
  end
  # def index
  #   @bids = Bid.all
  # end
  #
  # # GET /bids/1
  # # GET /bids/1.json
  # def show
  # end
  #
  # # GET /bids/new
  # def new
  #   @auction = Auction.find params[:id]
  #   @bid = Bid.new
  # end
  #
  # # GET /bids/1/edit
  # def edit
  # end
  #
  # # POST /bids
  # # POST /bids.json
  # def create
  #   @bid = Bid.new(bid_params)
  #
  #   respond_to do |format|
  #     if @bid.save
  #       format.html { redirect_to @bid, notice: 'Bid was successfully created.' }
  #       format.json { render :show, status: :created, location: @bid }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @bid.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /bids/1
  # # PATCH/PUT /bids/1.json
  # def update
  #   respond_to do |format|
  #     if @bid.update(bid_params)
  #       format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @bid }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @bid.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /bids/1
  # # DELETE /bids/1.json
  # def destroy
  #   @bid.destroy
  #   respond_to do |format|
  #     format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  def authorize_user!
    @auction = Auction.find params[:auction_id]

    if current_user == @auction.user_id
      redirect_to auction_path(@auction), alert: "You can't bid on your own item"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:amount, :user_id, :auction_id)
    end

    private

    def find_auction
      @auction = Auction.find params[:id]
    end
end
