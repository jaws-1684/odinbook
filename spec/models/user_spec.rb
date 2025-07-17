require 'rails_helper'

RSpec.describe User, type: :model do
  #bots
  let!(:harry) { create(:user, full_name: "Harry Bot") }
  let!(:bond) { create(:user, full_name: "Bond Bot") }
  let! (:bots) {[harry, bond]}
  let(:tested_user_0) { create(:user, :with_friends, friends: bots) }
  let(:tested_user_1) { create(:user, :with_received_invitations, invitators: bots) }
  let(:tested_user_2) { create(:user, :with_sent_invitations, invitees: bots) }

  describe "#friends" do
    subject(:tested_users_friends) { tested_user_0.friends }
    context 'when checking a user with friends' do
      it { is_expected.to be_an(Array) }
      it 'returns an array of friends' do
         expect(subject).to eql [ harry, bond ]
      end
      it 'never includes the user themselves in their friends list' do
        expect(subject.include? tested_user_0).to be false
      end
      it 'is uniq' do
        expect(subject.uniq).to eql subject
      end
    end

    context 'when checking a user with no friends' do
      it 'returns an empty array when the user has no friends' do
        expect(harry.friends).to be_empty
      end
    end
  end

  describe "#received_invitations" do
    subject(:tested_user_received_invitations) { tested_user_1.received_invitations }
    context "when checking a user with received invitations" do
       it { is_expected.to be_an(Array) }
       it 'returns an array of invitations' do
         expect(subject).to eql [ harry, bond ]
      end
    end
    context "when checking a user with no received invitations" do
      it 'returns an empty array when the user has no invitations' do
        expect(harry.received_invitations).to be_empty
      end
    end
  end

  describe "#sent_invitations" do
    subject(:tested_user_2_sent_invitations) { tested_user_2.sent_invitations }
    context "when checking a user with sent invitations" do
       it { is_expected.to be_an(Array) }
       it 'returns an array of invitations' do
         expect(subject).to eql [ harry, bond ]
      end
    end
    context "when checking a user with no sent invitations" do
      it 'returns an empty array when the user has no invitations' do
        expect(harry.sent_invitations).to be_empty
      end
    end
  end

  describe "#search" do
    context "when checking an valid search input" do
      it "returns users with the matching full_name" do
        expect(described_class.search("Bond Bot")).to eq [bond]
      end
      it "returns the matching first names" do
        expect(described_class.search("Bond")).to eql [bond]
      end

      context "returns the matching surnames" do
        [:bond, :harry].each do |username|
          it "matches #{username} bot " do
            expect(described_class.search("bot").include?(bots.sample)).to be true 
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
        create(:address, user: tested_user_0)
      end
      it "returns the country name" do
        expect(tested_user_0.country_name(tested_user_0.country)).to eq "France"
      end
    end

    context "when a user does not have a country" do
      it "returns nil" do
        expect(tested_user_0.country_name).to be nil
      end
    end
  end
  
 
end

