require 'spec_helper'

module Feeder
  describe Item do
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
