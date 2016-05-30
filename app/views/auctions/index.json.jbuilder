json.array!(@auctions) do |auction|
  json.extract! auction, :id, :title, :description, :end_date, :reserve_price
  json.url auction_url(auction, format: :json)
end
