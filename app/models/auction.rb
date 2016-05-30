class Auction < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_many :users, through: :bids, dependent: :nullify

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :reserve_price, presence: true, numericality: {greater_than: 0}
  validate :end_date_cannot_be_in_the_past

   def end_date_cannot_be_in_the_past
     if end_date.present? && end_date < Date.today
       errors.add(:end_date, "can't be in the past")
     end
   end


  # def check_highest_bid
  #   highest_bid = self.bids.order("amount DESC").first.amount rescue 0
  #   self.price = highest_bid
  #   save
  # end


  def upcased_title
    title.upcase
  end

  def full_name
    user ? user.full_name : ""
  end
end
