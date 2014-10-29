require 'spec_helper'

module Feeder
  describe Report do
    describe "::by" do
      it "fetches reports by the given user" do
        user = User.new
        reports = create_list :feeder_report, 3, reporter: user
        create_list :feeder_report, 2, reporter: User.new

        expect(described_class.by(user)).to match_array reports
      end
    end

    describe "::handled" do
      it "fetches all reports that has been handled" do
        handled_reports = create_list :feeder_report, 3, :handled
        create_list :feeder_report, 2, :unhandled

        expect(described_class.handled).to match_array handled_reports
      end
    end

    describe "::unhandled" do
      it "fetches all reports that has not been handled" do
        create_list :feeder_report, 3, :handled
        unhandled_reports = create_list :feeder_report, 2, :unhandled
        handled_in_future = create_list :feeder_report, 2, :handled_in_future

        expect(described_class.unhandled).to match_array (unhandled_reports + handled_in_future)
      end
    end

    describe "#handle" do
      before { Timecop.freeze time }
      after  { Timecop.return }

      let(:time) { Time.now }

      it "sets the handled_at flag to the current time" do
        subject.handle
        expect(subject.handled_at).to eq time
      end
    end

    describe "reopen" do
      subject { create :feeder_report, handled_at: 1.day.ago }

      it "unsets the handled_at flag" do
        subject.reopen
        expect(subject.handled_at).to be_nil
      end
    end
  end
end
