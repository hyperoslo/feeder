require 'spec_helper'

describe Feeder do
  describe ".config" do

  end

  describe ".configure" do
    context "when no block is given" do
      it "raises an error" do
        expect { subject.configure }.to raise_error ArgumentError
      end
    end

    context "when a block is given" do
      let!(:config) { subject.config }

      it "yields to the config object" do
        expect { |b| subject.configure(&b) }.to yield_with_args config
      end
    end
  end
end
