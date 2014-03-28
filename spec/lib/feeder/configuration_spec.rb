require 'spec_helper'

describe Feeder::Configuration do
  it "sets the observers to an empty array upon initialization" do
    expect(subject.observables).to eq [ ]
  end

  it "sets default scopes order upon initialization" do
    expect(subject.scopes.count).to eq 2
  end

  describe "#add_observable" do
    it "adds an observable to @observables" do
      subject.add_observable "SomeObservable"

      expect(subject.observables).to match_array [ "SomeObservable" ]
    end
  end
end
