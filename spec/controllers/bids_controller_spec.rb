require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  let(:auction) { FactoryGirl.create(:auction) }
  let(:user) { FactoryGirl.create(:user) }

  describe "#new" do
    context "without a signed in user" do
      it "redirects to sign up page" do
        get :new, auction_id: auction.id
        expect(response).to redirect_to(new_user_path)
      end
    end
    context "with signed in user" do

      before { sign_in user }
      it "renders the new template" do
        get :new, auction_id: auction.id
        expect(response).to render_template(:new)
      end

      it "assigns a new bid instance variable" do
        get :new, auction_id: auction.id
        expect(assigns(:bid)).to be_a_new(Bid)
      end
    end
  end
end
