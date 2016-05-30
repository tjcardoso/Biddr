class AddHighBidToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :high_bid, :integer
  end
end
