require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do


  let(:auction) { FactoryGirl.create(:auction) }
  let(:user) { FactoryGirl.create(:user) }

  describe "#new" do
    before { sign_in user }
    before { get :new    }

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "assigns a auction object" do
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end

  describe "#create" do
    describe "with valid attributes" do
      before { sign_in user }
      def valid_request
        post :create, auction: FactoryGirl.attributes_for(:auction)
      end

      it "saves a record to the database" do

        count_before = Auction.count
        valid_request
        # expect(response.status).to eq(200)
        count_after = Auction.count

        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the auction's show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    describe "with invalid attributes" do
      def invalid_request
        post :create, auction: {goal: 12}
      end

      # it "renders the new template" do
      #   invalid_request
      #   expect(response).to render_template(:new)
      # end

      it "sets an alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end

      it "doesn't save a record to the database" do
        count_before = Auction.count
        invalid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before)
      end
    end
  end

  describe "#show" do
    before do
      get :show, id: auction.id
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets a auction instance variable" do
      expect(assigns(:auction)).to eq(auction)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns an instance variable to all auctions in the DB" do
      Auction.destroy_all
      c  = FactoryGirl.create(:auction)
      c1 = FactoryGirl.create(:auction)
      # expect(Auction.count).to eq(2)
      get :index
      expect(assigns(:auctions)).to eq([c, c1])
    end
  end


end
