require 'rails_helper'

RSpec.describe User, type: :model do
  let(:harry) do
      name = "harry" 
      described_class.create!(
        full_name: "Wild #{name.upcase}",
        email: "#{name.split(' ').first.downcase}.#{name.split(' ').last.downcase}@example.com",
        password: "password",
        password_confirmation: "password",
        avatar_url: "https://api.dicebear.com/9.x/adventurer/svg?seed=Easton&backgroundColor=b6e3f4"
        )
  end
   let(:bond) do
      name = "bond" 
      described_class.create!(
        full_name: "Wild #{name.upcase}",
        email: "#{name.split(' ').first.downcase}.#{name.split(' ').last.downcase}@example.com",
        password: "password",
        password_confirmation: "password",
        avatar_url: "https://api.dicebear.com/9.x/adventurer/svg?seed=Easton&backgroundColor=b6e3f4"
        )
  end
   let(:oscar) do
      name = "oscar" 
      described_class.create!(
        full_name: "Wild #{name.upcase}",
        email: "#{name.split(' ').first.downcase}.#{name.split(' ').last.downcase}@example.com",
        password: "password",
        password_confirmation: "password",
        avatar_url: "https://api.dicebear.com/9.x/adventurer/svg?seed=Easton&backgroundColor=b6e3f4"
        )
  end 
 
  subject(:oscar_friends) {oscar.friends}
 
  describe "#friends" do 
    context 'when checking a user with friends' do
      before do
        [harry, bond].each {|f| FriendRequest.create!(user_id: f.id, friend_id: oscar.id, status: 1) }
      end
      it { is_expected.to be_an(Array) }
      it 'returns an array of friends' do
         expect(subject).to eql [harry, bond]
      end
      it 'never includes the user themselves in their friends list' do
        expect(subject.include? oscar).to be false
      end   
      it 'is uniq' do
        expect(subject.uniq).to eql subject
      end
      
    end

    context 'when checking a user with no friends' do
      before do
        FriendRequest.destroy_all
      end
      it 'returns an empty array when the user has no friends' do
        friends = oscar.friends
        expect(friends).to be_empty
      end
    end
  end
end
