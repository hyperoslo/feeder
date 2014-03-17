require 'spec_helper'

module Feeder
  describe FeedsController do
    routes { Feeder::Engine.routes }

    describe "GET 'index'" do
      let!(:items) do
        10.times.map do
          m = Message.create header: 'Header', body: 'Body'
          Item.create feedable: m, published_at: Time.zone.now
        end.sort_by(&:published_at).reverse
      end

      it "returns http success" do
        get :index
        expect(response).to be_successful
      end

      it "fetches feed items ordered by publiction date, descending" do
        get :index
        expect(assigns(:items)).to eq items
      end
    end

  end
end
