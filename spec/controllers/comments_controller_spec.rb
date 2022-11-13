# require 'rails_helper'

# RSpec.describe CommentsController do
#   describe "POST create" do 
#     it "redirect when success" do
#       post :create, params: { user: assigns(:user), post: assigns(:post), body: "comment_body" }
#       response.should redirect_to(post_path(assigns(:post)))
#       # expect(assigns(:comment)).to eq([subject])
#     end

#     it "redirect when error" do
#       post :create, params: { user: assigns(:user), post: assigns(:post), body: nil }
#       response.should redirect_to(post_path(assigns(:post)))
#       # expect(assigns(:comment)).to eq([subject])
#     end
#   end
# end