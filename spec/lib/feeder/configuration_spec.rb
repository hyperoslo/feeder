require 'spec_helper'

describe Feeder::Configuration do
  it "sets the observers to an empty array upon initialization" do
    expect(subject.observables).to eq({})
  end

  it "sets default scopes order upon initialization" do
    expect(subject.scopes.count).to eq 1
  end

  describe ".observe" do
    it "adds an observable to @observables" do
      subject.observe "SomeObservable"

      expect(subject.observables).to eq({ "SomeObservable" => {} })
    end
  end
end
