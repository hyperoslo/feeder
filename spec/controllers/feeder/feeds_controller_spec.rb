require 'spec_helper'

module Feeder
  describe FeedsController do
    routes { Feeder::Engine.routes }

    describe "GET 'index'" do
      let!(:items) do
        50.times.map do
          message = Message.create header: 'Header', body: 'Body'
          item    = Item.create feedable: message, published_at: Time.zone.now
        end.sort_by(&:published_at).reverse
      end

      it "returns http success" do
        get :index
        expect(response).to be_successful
      end

      context 'without a limit' do
        it 'loads the default amount of items' do
          get :index
          expect(assigns(:items).count).to eq Feeder.config.default_limit
        end
      end

      context 'with a limit' do
        it 'loads the given amount of items' do
          get :index, limit: 5
          expect(assigns(:items).count).to eq 5
        end
      end

      context 'without stickies' do
        it 'fetches feed items ordered by publiction date, descending' do
          get :index
          expect(assigns(:items)).to eq items.take(Feeder.config.default_limit)
        end
      end

      context 'with stickies' do
        let!(:sticky) {
          message = Message.create header: 'Header', body: 'body'
          item    = Item.create feedable: message, published_at: Time.zone.now, created_at: 1.week.ago, sticky: true
        }

        it 'places stickies first' do
          get :index
          expect(assigns(:items).first).to eq sticky
        end
      end
    end

  end
end
