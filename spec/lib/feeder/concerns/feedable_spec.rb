require 'spec_helper'

describe Feeder::Concerns::Feedable do
  subject { Message.new }

  it 'responds to sticky' do
    expect(subject).to respond_to :sticky
  end

  it 'responds to sticky='  do
    expect(subject).to respond_to :sticky=
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
end
