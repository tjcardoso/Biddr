class AddDefaultToAuctionsCurrentPrice < ActiveRecord::Migration
  def change
    change_column_default(:auctions, :current_price, 0)
  end
end
