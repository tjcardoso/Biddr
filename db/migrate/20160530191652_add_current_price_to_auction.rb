class AddCurrentPriceToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :current_price, :integer
  end
end
