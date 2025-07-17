require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:harry) { create(:user, :with_posts) }
  let!(:bond) { create(:user, :with_posts) }
  let (:bots) {[harry, bond]}
  let!(:tested_user_0) { create(:user, :with_friends, friends: bots) }
  let(:tested_user_1) { create(:user) }
 

  describe "#subscribed_to" do
    context "when user has subscriptions" do
      subject(:feed) { described_class.subscribed_to(tested_user_0) } 
      it "returns posts posted by friends" do
        expect(feed.length).to eq 2 
      end
    end
    
    context "when user does not have subscriptions" do
      subject(:feed) { described_class.subscribed_to(tested_user_1) }
       it { is_expected.to be_empty }
    end
  end
end
