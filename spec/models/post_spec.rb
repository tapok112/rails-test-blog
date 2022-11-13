require 'rails_helper'

RSpec.describe Post do
  subject {
    described_class.new(title: "post_title",
                        body: "post_body")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "validate without body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end

  it "validate without title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "returns post body" do
    expect(subject.body).to eq("post_body")
  end

  it "returns post title" do
    expect(subject.title).to eq("post_title")
  end
end
