class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :amount, presence: true, numericality: {greater_than_or_equal_to: 1}

  # validate :check_if_highest_bid

  # after_save :update_auction
  # after_destroy :update_auction

  # def update_auction
  #   self.auction.check_highest_bid
  # end
  #
  # def check_if_highest_bid
  #    errors.add(:amount, "must be higher than current bid") unless (self.auction.price < self.amount)
  # end

  def full_name
    user ? user.full_name : ""
  end
end
