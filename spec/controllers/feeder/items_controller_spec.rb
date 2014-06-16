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

      context 'with stickies' do
        let!(:sticky) { create :feeder_item, :sticky, published_at: 2.day.ago }
        let!(:other)  { create :feeder_item, published_at: 1.day.ago }

        it 'places stickies first' do
          get :index
          expect(assigns(:items).first).to eq sticky
        end
      end
    end

    describe "POST 'recommend'" do
      let!(:item) { create :feeder_item }

      before do
        request.env['HTTP_REFERER'] = 'http://example.org'
      end

      it "returns http success" do
        post :recommend, id: item.id
        expect(response).to be_redirect
      end

      context 'authorized' do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double :authorized? => true)
        end

        it "recommends the item" do
          post :recommend, id: item.id
          expect(item.reload).to be_recommended
        end
      end

      context 'unauthorized' do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double :authorized? => false)
        end

        it "does not recommend the item" do
          post :recommend, id: item.id
          expect(item.reload).not_to be_recommended
        end

        it "issues a warning" do
          post :recommend, id: item.id
          expect(flash.count).to eq 1
        end
      end
    end
  end
end
