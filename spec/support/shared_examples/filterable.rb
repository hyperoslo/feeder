require 'spec_helper'

shared_examples "a filterable" do
  subject { described_class }

  describe "::filter" do
    before do
      create_list :message, 5
    end

    context "when provided scope as an argument" do
      let (:arguments) { Message.test_odd }
      let :expected do
        Feeder::Item.where(feedable_id: Message.test_odd.pluck(:id))
      end

      it "fetches only items based on filtering" do
        expect(subject.filter arguments).to match_array expected
      end
    end

    context "when provided multiple scopes as an argument do" do
      let (:arguments) { [Message.test_odd, Message.test_gte] }
      let :expected do
        Feeder::Item.where(feedable_id: Message.where("id >= ? and id % 2 = 1", 3).pluck(:id))
      end

      it "fetches only items based on filtering" do
        expect(subject.filter *arguments).to match_array expected
      end
    end

    context "when provide class as an argument" do
      let (:arguments) { Message }
      let :expected do
        Feeder::Item.where(feedable_id: Message.all.pluck(:id))
      end

      it "fetches only items based on filtering" do
        expect(subject.filter arguments).to match_array expected
      end
    end

    context "wher provide mixed set of arguments" do
      before do
        create_list :article, 5
      end

      let (:arguments) { [Message.test_odd, Article] }
      let :expected do
        Feeder::Item.where(
          "(feedable_type = ? and feedable_id % 2 = 1) OR (feedable_type = ?)",
          "Message", "Article"
        )
      end

      it "fetches only items based on filtering" do
        expect(subject.filter *arguments).to match_array expected
      end
    end
  end
end
