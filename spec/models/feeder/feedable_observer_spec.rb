require 'spec_helper'

describe Feeder::FeedableObserver do
  describe '.after_create' do
    subject { described_class.instance }

    let(:message) { create :message }

    around do |example|
      Timecop.freeze Time.now do
        example.run
      end
    end

    before do
      subject.after_create message
    end

    it 'creates a new feed item' do
      expect(Feeder::Item.count).to eq 1
    end

    it 'refers to the feedable' do
      expect(Feeder::Item.last.feedable).to eq message
    end

    it 'mirrors the created time' do
      expect(Feeder::Item.last.created_at).to eq message.created_at
    end

    it 'sets published_at to the current time' do
      expect(Feeder::Item.last.published_at).to eq Time.zone.now
    end

    context 'when the feedable is sticky' do
      let(:message) { create :message, sticky: true }

      it 'stickies' do
        expect(Feeder::Item.last.sticky).to eq true
      end
    end

    context 'when the feedable is not sticky' do
      let(:message) { create :message, sticky: false }

      it 'does not sticky' do
        expect(Feeder::Item.last.sticky).to eq false
      end
    end
  end
end
