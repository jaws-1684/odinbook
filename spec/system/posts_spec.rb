require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let(:post_title) { 'Understand current hundred continue seem fund.' }
  let(:post_body) do
    'Plant wait argue relationship away find term role. Phone rather image. May and note hot side like member. See sense several deep ground eye.'
  end

  before do
    driven_by(:rack_test)
  end

  context "when the user has no posts in feed" do
    let(:user) { create(:user) }

    before do
      login_as(user)
      visit '/feed'
    end

    it "shows a no posts message" do
      expect(page).to have_content 'You currently don’t have any posts'
    end
  end

  context "when the user has their own posts in feed" do
    let(:user) { create(:user, :with_posts) }

    before do
      login_as(user)
      visit '/feed'
    end

    it "displays the post title" do 
      expect(page).to have_content post_title
    end

    it "displays the post body" do
      expect(page).to have_content post_body
    end
  end

  context "when the user sees posts from subscriptions in feed" do
    let!(:user) { create(:user) }
    let!(:friend) do
      create(:user, :with_posts, :with_friends, friends: [user], full_name: "Test Bot")
    end

    before do
      login_as(user)
      visit '/feed'
    end

    it "displays the friend’s name" do
      expect(page).to have_content 'Test Bot'
    end

    it "displays the friend’s post title" do
      expect(page).to have_content post_title
    end

    it "displays the friend’s post body" do
      expect(page).to have_content post_body
    end
  end
end
