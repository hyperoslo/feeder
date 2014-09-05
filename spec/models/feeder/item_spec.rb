require 'spec_helper'

module Feeder
  describe Item do
    it_behaves_like "a filterable"

    describe "::blocked" do
      let(:blocked_item)   { create :feeder_item, blocked: true }
      let(:unblocked_item) { create :feeder_item, blocked: false }

      it "returns blocked items" do
        expect(described_class.blocked).to eq [blocked_item]
      end
    end

    describe "::unblocked" do
      let(:blocked_item)   { create :feeder_item, blocked: true }
      let(:unblocked_item) { create :feeder_item, blocked: false }

      it "returns unblocked items" do
        expect(described_class.unblocked).to eq [unblocked_item]
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

    describe "#report" do
      subject { create :feeder_item, reported: false }

      it "ensures the item is reported" do
        subject.report
        expect(subject).to be_reported
      end
    end

    describe "#block" do
      subject { create :feeder_item, blocked: false }

      it "ensures the item is blocked" do
        subject.block
        expect(subject).to be_blocked
      end
    end

    describe "#unreport" do
      subject { create :feeder_item, reported: true }

      it "ensures the item is not reported" do
        subject.unreport
        expect(subject).not_to be_reported
      end
    end

    describe "#unblock" do
      subject { create :feeder_item, blocked: true }

      it "ensures the item is not blocked" do
        subject.unblock
        expect(subject).not_to be_blocked
      end
    end
  end
end
