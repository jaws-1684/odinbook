require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "#subscribed_to" do
    context "when user has subscriptions" do
      let(:current_user) {create(:user)}
      let(:bond) {create(:user)}
      let(:oscar) {create(:user)}
      let(:harry) {create(:user)}
    end
    
    context "when user does not have subscriptions" do
    end
  end
end
