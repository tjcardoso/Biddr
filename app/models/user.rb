class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :auctions,  dependent: :destroy
  has_many :bids,  dependent: :destroy


  def full_name
    name = "#{first_name} #{last_name}"
    name.titleize
  end

  def titleize(string)
    string.split(" ").map {|x| x.capitalize}
  end

end
