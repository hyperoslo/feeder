require 'spec_helper'

describe Feeder::Configuration do
  it "sets test mode to false by default" do
    expect(subject.test_mode).to be_falsey
  end
end
