require "spec_helper"

describe Feeder::AuthorizationAdapters::Base do
  let(:user) { create :user }

  subject do
    described_class.new user
  end

  it "should authorize" do
    expect(subject).not_to be_authorized(:manage)
  end
end
