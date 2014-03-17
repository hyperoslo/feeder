require 'spec_helper'

describe Feeder::Configuration do
  it "sets the observers to an empty array upon initialization" do
    expect(subject.observables).to eq [ ]
  end

  it "sets a default sort order upon initialization" do
    expect(subject.sort_order).to eq({ created_at: :desc })
  end

  describe "#add_observable" do
    it "adds an observable to @observables" do
      subject.add_observable "SomeObservable"

      expect(subject.observables).to match_array [ "SomeObservable" ]
    end
  end
end
