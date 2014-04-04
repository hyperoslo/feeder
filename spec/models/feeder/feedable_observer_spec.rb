require 'spec_helper'

describe Feeder::FeedableObserver do
  subject { described_class.instance }

  let(:message) { create :message }

  around do |example|
    Timecop.freeze Time.now do
      example.run
    end
  end

  describe '.after_save' do
    context 'with a message that is no longer sticky' do
      let(:message) { create :message, sticky: true }

      before do
        subject.after_create message

        message.update sticky: false

        subject.after_save message
      end

      it 'should update the feeder item to no longer be sticky' do
        expect(message.feeder_item.sticky).to eq false
      end
    end
  end

  describe '.after_create' do
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

    context 'when the feedable is configured to not feed' do
      around do |example|
        Feeder.temporarily observables: { Message => { if: -> message { message.nil? }} } do
          example.run
        end
      end

      it 'does not create a feed item' do
        expect(Feeder::Item.count).to eq 0
      end
    end
  end
end
