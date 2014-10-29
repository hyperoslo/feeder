require 'spec_helper'

module Feeder
  describe Item do
    it_behaves_like "a filterable"

    subject { create :feeder_item }

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
      subject { create :feeder_item }

      context "when passed a reporter" do
        it "ensures the item is reported by that person" do
          user = User.new
          subject.report user
          expect(subject).to be_reported_by user
        end
      end

      context "when not passed a reporter" do
        it "ensures the item is reported" do
          subject.report
          expect(subject).to be_reported
        end
      end
    end

    describe "#unreport" do
      subject { create :feeder_item, :reported }
      let(:user) { User.new }

      context "when passed a reporter" do
        it "ensures the item is not reported by that user" do
          create :feeder_report, item: subject, reporter: user

          subject.unreport user
          expect(subject).not_to be_reported_by user
        end

        it "stills keeps other reports by other users" do
          subject.unreport user
          expect(subject).to be_reported
        end
      end

      context "when not passed a reporter" do
        it "ensures the item is not reported" do
          subject.unreport
          expect(subject).not_to be_reported
        end
      end
    end

    describe "#block" do
      subject { create :feeder_item, blocked: false }

      it "ensures the item is blocked" do
        subject.block
        expect(subject).to be_blocked
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

    describe "#reported?" do
      context "when reported by any user or anonymously" do
        before { subject.reports << create(:feeder_report) }

        it "returns true" do
          expect(subject).to be_reported
        end
      end

      context "when not reported by anyone" do
        before { subject.update reports: [] }

        it "returns false" do
          expect(subject).not_to be_reported
        end
      end
    end

    describe "#reported_by?" do
      let(:user) { User.new }

      context "when reported by the given user" do
        before { subject.reports << create(:feeder_report, reporter: user) }

        it "returns true" do
          expect(subject).to be_reported_by user
        end
      end

      context "when not reported by given user" do
        before { subject.reports << create(:feeder_report, reporter: User.new) }

        it "returns true" do
          expect(subject).not_to be_reported_by user
        end
      end
    end
  end
end
