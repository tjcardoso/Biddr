class BidsController < ApplicationController
  # before_action :set_bid, only: [:show, :edit, :update]
  before_action :authenticate_user!


  def create
    @auction      = Auction.find params[:auction_id]
    bid_params    = params.require(:bid).permit(:amount)
    @bid          = Bid.new bid_params
    @bid.auction  = @auction
    @bid.user     = current_user
    if @bid.amount < @auction.current_price
      redirect_to auction_path(@auction), alert: "Your bid is lower than the current price"
    end

    if current_user == @auction.user
      redirect_to auction_path(@auction), alert: "You can't bid on your own item"
    end
    respond_to do |format|
      if @bid.save
        @auction.current_price = @bid.amount
        @auction.save
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
