require 'rails_helper'

RSpec.describe User do
  subject {
    described_class.new(email: "user@example.com",
                        name: "tapok",
                        password: "123456")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "validate without email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end


  it "validate without password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "returns email" do
    expect(subject.email).to eq("user@example.com")
  end

  it "returns name" do
    expect(subject.name).to eq("tapok")
  end
end