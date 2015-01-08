require "spec_helper"

describe "feeder/items/_item.html.erb" do
  helper(Feeder::AuthorizationHelper)
  helper(Feeder::LikeHelper)

  before do
    render partial: "feeder/items/item.html.erb", locals: {
      item: item
    }
  end

  around do |example|
    Feeder.configure do |config|
      config.current_user_method = "current_user"
    end

    example.run

    Feeder.configure do |config|
      config.current_user_method = nil
    end
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

  context "liked item" do
    let(:message) { create :message }
    let(:item)    { create :feeder_item, feedable: message }
    let(:user)    { create :user }

    before do
      item.liked_by user
    end

    context "for users that can like" do
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

      it "displays a link to unlike" do
        expect(rendered).to have_selector "a", text: "Unlike"
      end
    end
  end

  context "unliked item" do
    let(:message) { create :message }
    let(:item)    { create :feeder_item, feedable: message }
    let(:user)    { create :user }

    context "for users that can like" do
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

      it "displays a link to like" do
        expect(rendered).to have_selector "a", text: "Like"
      end
    end
  end
end
