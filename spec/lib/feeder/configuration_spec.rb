require 'spec_helper'

describe Feeder::Configuration do
  it "sets default scopes order upon initialization" do
    expect(subject.scopes.count).to eq 2
  end

  it "sets test mode to false by default" do
    expect(subject.test_mode).to be_falsey
  end
end
