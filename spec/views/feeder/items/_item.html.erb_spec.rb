require "spec_helper"

describe "feeder/items/_item.html.erb" do
  helper(Feeder::AuthorizationHelper)

  before do
    render partial: "feeder/items/item.html.erb", locals: {
      item: item
    }
  end

  context "recommended item" do
    let(:message) { create :message }
    let(:item)    { create :feeder_item, feedable: message, recommended: true }

    it "shows that it is recommended" do
      expect(rendered).to match "recommended"
    end

    context "for users that can recommend" do
      before do
        Feeder.configure do |config|
          config.authorization_adapter = EveryoneAdapter
        end

        render partial: "feeder/items/item.html.erb", locals: {
          item: item
        }
      end

      after do
        Feeder.configure do |config|
          config.authorization_adapter = Feeder::AuthorizationAdapters::Base
        end
      end

      it "displays a link to unrecommend" do
        expect(rendered).to have_selector "a", text: "Unrecommend"
      end
    end
  end

  context "unrecommended item" do
    let(:message) { create :message }
    let(:item)    { create :feeder_item, feedable: message, recommended: false }

    it "does not show that it is recommended" do
      expect(rendered).not_to match "recommended"
    end
  end
end
