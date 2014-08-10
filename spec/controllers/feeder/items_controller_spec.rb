require 'spec_helper'

module Feeder
  describe ItemsController do
    routes { Feeder::Engine.routes }

    describe "GET 'index'" do
      let!(:items) do
        create_list :feeder_item, 50
      end

      it "returns http success" do
        get :index
        expect(response).to be_successful
      end

      context 'with a limit' do
        it 'loads the given amount of items' do
          get :index, limit: 5
          expect(assigns(:items).count).to eq 5
        end
      end

      context 'with a page' do
        let!(:very_last) { create :feeder_item }

        it 'paginates items' do
          get :index, page: 2, limit: 1
          expect(assigns(:items)).to eq [items.last]
        end
      end

      context 'with stickies' do
        let!(:sticky) { create :feeder_item, :sticky, published_at: 2.day.ago }
        let!(:other)  { create :feeder_item, published_at: 1.day.ago }

        it 'places stickies first' do
          get :index
          expect(assigns(:items).first).to eq sticky
        end
      end
    end

  end
end
