require 'spec_helper'

describe Feeder::Configuration do
  it "sets the observers to an empty array upon initialization" do
    expect(subject.observables).to eq [ ]
  end

  describe "#add_observable" do
    it "adds an observable to @observables" do
      subject.add_observable "SomeObservable"

      expect(subject.observables).to match_array [ "SomeObservable" ]
    end
  end
end
