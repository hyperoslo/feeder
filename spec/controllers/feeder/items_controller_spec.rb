require "spec_helper"

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

      context "with a limit" do
        it "loads the given amount of items" do
          get :index, limit: 5
          expect(assigns(:items).count).to eq 5
        end
      end

      context "with a page" do
        let!(:very_last) { create :feeder_item }

        it "paginates items" do
          get :index, page: 2, limit: 1
          expect(assigns(:items)).to eq [items.last]
        end
      end

      context "with stickies" do
        let!(:sticky) { create :feeder_item, :sticky, published_at: 2.day.ago }
        let!(:other)  { create :feeder_item, published_at: 1.day.ago }

        it "places stickies first" do
          get :index
          expect(assigns(:items).first).to eq sticky
        end
      end
    end

    describe "POST 'recommend'" do
      let!(:item) { create :feeder_item }

      before do
        request.env["HTTP_REFERER"] = "http://example.org"
      end

      it "returns http success" do
        post :recommend, id: item.id
        expect(response).to be_redirect
      end

      context "authorized" do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double authorized?: true)
        end

        it "recommends the item" do
          post :recommend, id: item.id
          expect(item.reload).to be_recommended
        end

        it "issues a notice" do
          post :recommend, id: item.id
          expect(flash[:notice]).to eq I18n.t("feeder.views.recommended")
        end
      end

      context "unauthorized" do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double authorized?: false)
        end

        it "does not recommend the item" do
          post :recommend, id: item.id
          expect(item.reload).not_to be_recommended
        end

        it "issues an error" do
          post :recommend, id: item.id
          expect(flash[:error]).to eq I18n.t("feeder.views.unauthorized")
        end
      end
    end

    describe "POST 'unrecommend'" do
      let!(:item) { create :feeder_item, recommended: true }

      before do
        request.env["HTTP_REFERER"] = "http://example.org"
      end

      it "returns http success" do
        post :unrecommend, id: item.id
        expect(response).to be_redirect
      end

      context "authorized" do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double :authorized? => true)
        end

        it "recommends the item" do
          post :unrecommend, id: item.id
          expect(item.reload).not_to be_recommended
        end

        it "issues a notice" do
          post :unrecommend, id: item.id
          expect(flash[:notice]).to eq I18n.t("feeder.views.unrecommended")
        end
      end

      context "unauthorized" do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double :authorized? => false)
        end

        it "does not unrecommend the item" do
          post :recommend, id: item.id
          expect(item.reload).to be_recommended
        end

        it "issues an error" do
          post :recommend, id: item.id
          expect(flash[:error]).to eq I18n.t("feeder.views.unauthorized")
        end
      end
    end

    describe "POST 'like'" do
      let!(:item) { create :feeder_item }
      let!(:user) { create :user }

      before do
        request.env["HTTP_REFERER"] = "http://example.org"

        class Feeder::ItemsController
          def current_user
            User.first
          end
        end
      end

      it "returns http success" do
        post :like, id: item.id
        expect(response).to be_redirect
      end

      context "authorized" do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double authorized?: true)
        end

        it "likes the item" do
          post :like, id: item.id
          expect(response).to be_redirect
          expect(item.get_likes(voter: user).any?).to be true
        end

        context "with valid scope" do
          before do
            Feeder.config.like_scopes << :foo
          end

          it "likes the item" do
            post :like, id: item.id, like_scope: "foo"
            expect(item.get_likes(voter: user, vote_scope: "foo").any?).to be true
          end
        end

        context "with invalid scope" do
          it "likes the item" do
            post :like, id: item.id, like_scope: "bar"
            expect(item.get_likes(voter: user, vote_scope: "bar").any?).to be false
          end
        end
      end

      context "unauthorized" do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double authorized?: false)
        end

        it "does not like the item" do
          post :like, id: item.id
          expect(item.get_likes(voter: user).any?).to be false
        end
      end

      after do
        class Feeder::ItemsController
          def current_user
          end
        end
      end
    end

    describe "POST 'unlike'" do
      let!(:item) { create :feeder_item }
      let!(:user) { create :user }

      before do
        item.liked_by user
        request.env["HTTP_REFERER"] = "http://example.org"

        class Feeder::ItemsController
          def current_user
            User.first
          end
        end
      end

      it "returns http success" do
        post :unlike, id: item.id
        expect(response).to be_redirect
      end

      context "authorized" do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double authorized?: true)
        end

        it "unlikes the item" do
          post :unlike, id: item.id
          expect(item.get_likes(voter: user).any?).to be false
        end
      end

      context "unauthorized" do
        before do
          expect(controller).to receive(:authorization_adapter).and_return(double authorized?: false)
        end

        it "does not unlike the item" do
          post :unlike, id: item.id
          expect(item.get_likes(voter: user).any?).to be true
        end
      end

      after do
        class Feeder::ItemsController
          def current_user
          end
        end
      end
    end
  end
end
