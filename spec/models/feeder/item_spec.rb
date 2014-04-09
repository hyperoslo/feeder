require 'spec_helper'

module Feeder
  describe Item do
    describe "scopes" do
      subject { described_class }

      describe "::filter" do
        context "when provided a hash with the key being a feedable" do
          let(:feedables) { create_list :feeder_item, 1 }
          let(:arguments) { { Feeder::Item => ids } }

          context "and the value being a list of IDs" do
            let(:ids)       { feedables.map &:id }

            let!(:expected) do
              feedables.each.map do |feedable|
                create :feeder_item, feedable: feedable
              end
            end

            before do
              others = create_list :feeder_item, 1
              others.each { |feedable| create :feeder_item, feedable: feedable }
            end

            it "fetches only items based on the filter" do
              expect(subject.filter arguments).to match_array expected
            end
          end

          context "and the value being :all" do
            let(:ids)       { :all }

            let!(:expected) do
              Feeder::Item.where feedable_type: "Feeder::Item"
            end

            before do
              others = create_list :feeder_item, 1
              others.each { |feedable| create :feeder_item, feedable: feedable }
            end

            it "fetches only items based on the filter" do
              expect(subject.filter arguments).to match_array expected
            end
          end
        end
      end
    end

    describe "#type" do
      it "returns the lowercase version of the feedable's type, separating words with an underscore" do
        subject.stub(:feedable_type).and_return "SomeFeedable"
        expect(subject.type).to eq "some_feedable"
      end

      context "when the feedable is namespaced" do
        it "splits each namespace with a forward slash" do
          subject.stub(:feedable_type).and_return "CoolApp::SomeFeedable"
          expect(subject.type).to eq "cool_app/some_feedable"
        end
      end
    end
  end
end
