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

    describe "#liked_by?" do
      subject { create :feeder_item }
      let(:user) { create :user }

      context "when it is liked" do
        before do
          subject.liked_by user
        end

        it "determines if the item is liked given user" do
          expect(subject.liked_by?(user)).to be true
        end

        context "with scope" do
          it "determines the item is liked by given" do
            subject.liked_by user, vote_scope: "foo"
            expect(subject.liked_by?(user, "foo")).to be true
          end
        end
      end

      context "when it's not liked" do
        it "determines if the item is liked by given user" do
          expect(subject.liked_by?(user)).to be false
        end
      end
    end

    describe "#liked_by?" do
      subject { create :feeder_item }
      let(:user) { create :user }

      context "when it is liked" do
        before do
          subject.liked_by user
        end

        it "determines if the item is liked" do
          expect(subject.liked?).to be true
        end
      end

      context "when it's not liked" do
        it "determines if the item is liked" do
          expect(subject.liked?).to be false
        end
      end
    end
  end
end
