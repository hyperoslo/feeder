require 'spec_helper'

shared_examples "a filterable" do
  subject { described_class }

  describe "::filter" do
#    context "when provided scope as an argument" do
#      before do
#        create_list :message, 5
#      end
#
#      let (:arguments) { Message.test_odd }
#      let :expected do
#        Feeder::Item.where(feedable_id: Message.test_odd.pluck(:id))
#      end
#
#      it "fetches only items based on filtering" do
#        expect(subject.filter arguments).to match_array expected
#      end
#    end
#
    context "when provide class as an argument" do
      before do
        create_list :message, 5
      end

      let (:arguments) { Message }
      let :expected do
        Feeder::Item.where(feedable_id: Message.all.pluck(:id))
      end

      it "fetches only items based on filtering" do
        expect(subject.filter arguments).to match_array expected
      end

    end
#    context "when provided a hash" do
#      let(:left) { create_list :feeder_item, 1 }
#      let(:arguments) { { Feeder::Item => right } }
#
#      context "and the value being a list of IDs" do
#        let(:right) { left.map &:id }
#
#        let!(:expected) do
#          left.each.map do |feedable|
#            create :feeder_item, feedable: feedable
#          end
#        end
#
#        before do
#          others = create_list :feeder_item, 1
#          others.each { |feedable| create :feeder_item, feedable: feedable }
#        end
#
#        it "fetches only items based on the filter" do
#          expect(subject.filter arguments).to match_array expected
#        end
#      end
#
#      context "and the value being :all" do
#        let(:right) { :all }
#
#        let!(:expected) do
#          Feeder::Item.where feedable_type: "Feeder::Item"
#        end
#
#        before do
#          others = create_list :feeder_item, 1
#          others.each { |feedable| create :feeder_item, feedable: feedable }
#        end
#
#        it "fetches only items based on the filter" do
#          expect(subject.filter arguments).to match_array expected
#        end
#      end
#    end
  end
end
