require 'rails_helper'

RSpec.describe CommentsController do
  describe 'POST create' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:params) do
      {
        user_id: user.id,
        post_id: post.id,
        comment: attributes_for(:comment)
      }
    end

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    subject { process :create, method: :post, params: params }

    it 'create a new comment with valid attributes' do
      expect{subject}.to change(Comment,:count).by(1)
    end

    it 'redirects to post' do
      expect(subject).to redirect_to post_path(post)
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:comment) { create(:comment, user: user, post: post) }
    let(:params) do
      {
        id: comment.id,
        user_id: user.id,
        post_id: post
      }
    end    

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    subject { process :destroy, method: :delete, params: params }

    it 'destroy comment' do
      comment.reload
      expect{subject}.to change(Comment,:count).by(-1)
    end

    it 'redirects to post' do
      expect(subject).to redirect_to post_path(post)
    end
  end
end