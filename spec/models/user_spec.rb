require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:current_user) {create(:user, full_name: "Oscar Bot")}
  #Friend bots
  subject(:harry) {create(:user, full_name: "Harry Bot")}
  subject(:bond) {create(:user, full_name: "Bond bot")}
  let (:friends) { [harry, bond]}
  
  describe "#friends" do
    subject(:oscar_friends) { current_user.friends }
    context 'when checking a user with friends' do
      before do
        [ harry, bond ].each { |f| FriendRequest.create!(user_id: f.id, friend_id: current_user.id, status: 1) }
      end
      it { is_expected.to be_an(Array) }
      it 'returns an array of friends' do
         expect(subject).to eql [ harry, bond ]
      end
      it 'never includes the user themselves in their friends list' do
        expect(subject.include? current_user).to be false
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
        expect(subject).to be_empty
      end
    end
  end

  describe "#received_invitations" do
    subject(:oscar_received_invitations) { current_user.received_invitations }
    context "when checking a user with received invitations" do
      before do
        [ harry, bond ].each { |f| FriendRequest.create!(user_id: f.id, friend_id: current_user.id, status: 0) }
      end
       it { is_expected.to be_an(Array) }
       it 'returns an array of invitations' do
         expect(subject).to eql [ harry, bond ]
      end
    end
    context "when checking a user with no received invitations" do
      before do
        FriendRequest.destroy_all
      end
      it 'returns an empty array when the user has no invitations' do
        expect(subject).to be_empty
      end
    end
  end

  describe "#sent_invitations" do
    subject(:oscar_sent_invitations) { current_user.sent_invitations }
    context "when checking a user with sent invitations" do
      before do
        [ harry, bond ].each { |f| FriendRequest.create!(user_id: current_user.id, friend_id: f.id, status: 0) }
      end
       it { is_expected.to be_an(Array) }
       it 'returns an array of invitations' do
         expect(subject).to eql [ harry, bond ]
      end
    end
    context "when checking a user with no sent invitations" do
      before do
        FriendRequest.destroy_all
      end
      it 'returns an empty array when the user has no invitations' do
        expect(subject).to be_empty
      end
    end
  end

  describe "#search" do
    before do
      [ harry, bond ].each { |f| FriendRequest.create!(user_id: f.id, friend_id: current_user.id, status: 1) }
    end

    context "when checking an valid search input" do
      it "returns users with the matching full_name" do
        expect(described_class.search("Bond Bot")).to eql [bond]
      end
      it "returns the matching first names" do
        expect(described_class.search("Bond")).to eql [bond]
      end

      context "returns the matching surnames" do
        [:bond, :harry, :current_user].each do |username|
          it "matches #{username} bot " do
            expect(described_class.search("bot").include?(friends.sample)).to be true 
          end
        end  
      end
      it "is case insensitive" do
        expect(described_class.search("bond bot")).to eql [bond]
      end
    end

    context "when checking an invalid search input" do
      it "rejects long strings" do
        result = described_class.search("LoremipsumdolorsitametconsecteturadipiscingelitSeddoeiusmodtemporincididuntutlaboreetdoloremagnaaliquaUtenimadminimveniamquisnostrudexercitationullamcolaborisnisiutaliquipexeacommodoconsequatDuisautiruredolorinreprehenderitinvoluptatevelitessecillumdoloreeufugiatnullapariaturExcepteursintoccaecatcupidatatnonproidentSuntinculpaquiOfficiadeseruntmollitanimidestlaborumLoremipsumdolorsitametconsecteturadipiscingelitVestibulumanteipsumprimisinfaucibusorciluctusetultricessuspendissepotentiSedegestaslectusvelitSedliberovenenatisdignissimnonauguenonpellentesqueFusceelementumlobortisipsumvitaescelerisquesedCrasfacilisisconsecteturtellusCurabiturvehiculanisiinterdumfelisviverraaliquamSedlobortiserategeustemporuto
        ")
        expect(result).to be_empty
      end
      it "accepts only word inputs" do
        expect(described_class.search("mary#1- #@45566")).to be_empty
      end
    end
    context "when searching for a inexistent user" do
      it "returns an empty array" do
        expect(described_class.search("John Doe")).to be_empty
      end
    end  
  end

  describe "#country_name" do
    context "when a user has a country" do
      before do
        Address.create!(user_id: current_user.id, city: 'Paris', country: 'FR')
      end
      it "returns the country name" do
        expect(current_user.country_name(current_user.country)).to eq "France"
        end
      end

    context "when a user does not have a country" do
      it "returns nil" do
        expect(bond.country_name).to be nil
      end
    end
  end
  
 
end

