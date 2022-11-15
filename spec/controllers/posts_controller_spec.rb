require 'rails_helper'

RSpec.describe PostsController do
  describe 'GET index' do
    it "has a 200 status code" do
      get :index
      is_expected.to render_template :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    let(:post) { create(:post) }

    it "has a 200 status code" do
      get :show, params: { id: post }
      is_expected.to render_template :show
      expect(response.status).to eq(200)
    end
  end

  describe 'GET user_posts_list' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it "has a 200 status code" do
      get :user_posts_list
      is_expected.to render_template :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET new' do
    let(:user) { create(:user) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    it "has a 200 status code" do
      get :new
      is_expected.to render_template :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }
    let(:params) do
      { 
        post: {
          user_id: user.id,
          title: Faker::Lorem.word,
          body: "There are five steps involved."
        }
      }
    end

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    subject { process :create, method: :post, params: params }

    it 'create a new post with valid attributes' do
      expect{subject}.to change(Post,:count).by(1)
    end

    it 'redirects to post' do
      expect(subject).to redirect_to(post_path(assigns(:post)))
    end
  end

  describe 'GET edit' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    subject { process :edit, method: :get, params: { id: post } }

    it "has a 200 status code" do
      expect(response.status).to eq(200)
      expect(subject).to render_template :edit
    end
  end

  describe 'PATCH update' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }
    let(:params) do
      {
        id: post,
        post: {
          title: post.title,
          body: Faker::Movies::HarryPotter.book
        }    
      }
    end

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    subject { process :update, method: :patch, params: params }

    it "redirect to post path" do
      expect(subject).to redirect_to(post_path(assigns(:post)))
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user_id: user.id) }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user
    end

    subject { process :destroy, method: :delete, params: { id: post } }

    it "redirect to posts path" do
      expect(subject).to redirect_to(posts_path)
    end
  end
end