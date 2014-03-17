require 'spec_helper'

module Feeder
  describe FeedsController do
    routes { Feeder::Engine.routes }

    describe "GET 'index'" do
      it "returns http success" do
        get :index
        expect(response).to be_successful
      end
    end

  end
end
