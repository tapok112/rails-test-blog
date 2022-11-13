require 'rails_helper'

RSpec.describe Comment do
  
  let(:user) {
    User.new(:email => "user@example.com", :password => "123456")
  }
  
  let(:post) {
    Post.new(:title => "post_title", :body => "post_body")
  }
  
  subject {
    described_class.new(body: "comment_body", user: user, post: post)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "validate without user" do
    subject.user = nil
    expect(subject).to_not be_valid
  end


  it "validate without post" do
    subject.post = nil
    expect(subject).to_not be_valid
  end

  it "returns body" do
    expect(subject.body).to eq("comment_body")
  end
end