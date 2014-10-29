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
  end
end
