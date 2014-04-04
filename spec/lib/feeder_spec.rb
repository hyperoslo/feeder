require 'spec_helper'

describe Feeder do
  describe ".config" do

  end

  describe ".configure" do
    context "when no block is given" do
      it "does nothing" do
        expect(subject.configure).to be nil
      end
    end

    context "when a block is given" do
      let!(:config) { subject.config }

      it "yields to the config object" do
        expect { |b| subject.configure(&b) }.to yield_with_args config
      end
    end
  end

  describe '.temporarily' do
    it 'sets temporary configuration options' do
      expect(Feeder.config.scopes.count).to eq 1

      Feeder.temporarily scopes: [] do
        expect(Feeder.config.scopes.count).to eq 0
      end

      expect(Feeder.config.scopes.count).to eq 1
    end
  end
end
