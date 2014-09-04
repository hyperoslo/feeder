require 'spec_helper'

describe Feeder::Concerns::Feedable do
  subject { Message.new }
  let(:message) { create :message }

  around do |example|
    Timecop.freeze Time.now do
      example.run
    end
  end

  it 'responds to sticky' do
    expect(subject).to respond_to :sticky
  end

  it 'responds to sticky='  do
    expect(subject).to respond_to :sticky=
  end

  it 'converts strings to booleans' do
    subject.sticky = "0"

    expect(subject.sticky).to eq false
  end

  context 'with a feeder item' do
    before do
      expect(subject).to receive(:feeder_item).and_return(double sticky: true).at_least(1).times
    end

    it 'delegates sticky to it' do
      expect(subject.sticky).to eq true
    end
  end

  context 'without a feeder item' do
    before do
      expect(subject).to receive(:feeder_item).and_return(nil).at_least(1).times
    end

    it 'mainstains state internally' do
      expect(subject.sticky).to eq false
    end
  end

  context 'when set test mode' do
    before { subject.save }

    around do |example|
      Feeder.configure { |config| config.test_mode = true }
      example.run
      Feeder.configure { |config| config.test_mode = false }
    end

    it 'does not create feeder item' do
      expect(Feeder::Item.count).to eq 0
    end
  end

  describe '#_update_feeder_item' do
    let(:message) { create :message, sticky: true }

    it 'should update the feeder item to no longer be sticky' do
      expect(message.feeder_item.sticky).to eq true
      message.update sticky: false
      expect(message.feeder_item.sticky).to eq false
    end
  end

  describe '#_create_feeder_item' do
    before { subject.save }

    it 'creates a new feed item' do
      expect(Feeder::Item.count).to eq 1
    end

    it 'refers to the feedable' do
      expect(Feeder::Item.last.feedable).to eq subject
    end

    it 'mirrors the created time' do
      expect(Feeder::Item.last.created_at.to_i).to eq message.created_at.to_i
    end

    it 'sets published_at to the current time' do
      expect(Feeder::Item.last.published_at.to_i).to eq Time.zone.now.to_i
    end

    context 'when the feedable is sticky' do
      let!(:message) { create :message, sticky: true }

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
      context 'with a lambda' do
        around do |example|
          Message.feedable_options = { if: -> message { message.nil? } }
          example.run
          Message.feedable_options = nil
        end

        it 'does not create a feed item' do
          expect(Feeder::Item.count).to eq 0
        end
      end

      context 'with a symbol' do
        around do |example|
          Message.feedable_options = { if: :nil? }
          example.run
          Message.feedable_options = nil
        end

        it 'does not create a feed item' do
          expect(Feeder::Item.count).to eq 0
        end
      end
    end
  end
end
