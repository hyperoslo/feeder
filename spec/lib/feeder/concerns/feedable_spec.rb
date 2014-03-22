require 'spec_helper'

describe Feeder::Concerns::Feedable do
  class Model
    extend Feeder::ActiveRecord::Extensions

    feedable
  end

  subject { Model.new }

  it 'responds to sticky' do
    expect(subject).to respond_to :sticky
  end

  it 'responds to sticky='  do
    expect(subject).to respond_to :sticky=
  end

  it 'maintains state' do
    subject.sticky = true
    expect(subject.sticky).to eq true

    subject.sticky = false
    expect(subject.sticky).to eq false
  end
end
