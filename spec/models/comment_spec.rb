require 'rails_helper'

RSpec.describe Comment, type: :model do
 let(:user) {create(:user, full_name: "John Doe")} 
 let(:post) {create(:post, user: user)}
 let!(:comment) {create(:comment, commentable: post, user: user)}

 it "creates the comment post association properly" do
  expect(comment.commentable).to eq post 
 end
 it "creates the comment user association properly" do
  expect(comment.user).to eq user
 end

end
