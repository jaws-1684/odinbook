require 'rails_helper'

RSpec.describe "Comments", type: :system do
  
  before do
    driven_by(:selenium_chrome_headless)
  end

  context "when the user has their own comments on their own posts in feed" do
    let(:user) {create(:user, full_name: "John Doe")} 
    let!(:post) {create(:post, user: user)}
    let!(:comment) {create(:comment, commentable: post, user: user)}
    before do
      login_as(user)
      visit '/feed'
      click_link "#{post.id}_comments"
    end

    it "displays the comments" do
      expect(page).to have_content comment.body
    end
  end

  context "when the user sees comments on posts from subscriptions in feed" do
    let!(:bot) { create(:user) }
    let!(:friend) do
      create(:user, :with_friends, friends: [bot], full_name: "Test Bot")
    end
    let!(:post) {create(:post, user: friend)}
    let!(:comment) {create(:comment, commentable: post, user: friend)}

    before do
      login_as(bot)
      visit '/feed'
      click_link "#{post.id}_comments"
    end

    it "displays the comments" do
      expect(page).to have_content friend.comments.first.body
    end
   
  end
end
