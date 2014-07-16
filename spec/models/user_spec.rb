require 'spec_helper'

describe User do
  let(:user) { build :user }
  
  describe 'class methods' do
    describe '#winrate_per_day' do
      let!(:season) { create :season }
      
      it 'returns an array the size of days + 1' do
        User.winrate_per_day(user.id, 10).should have(11).elements
      end
    end
  end
  
  describe 'instance methods' do
    describe '#get_user_key' do
      it 'sets the userkey when it is not present' do
        user.get_userkey
        
        user.userkey.should_not be_empty
      end
      
      it 'returns the userkey' do
        user.userkey = '666'
        
        user.get_userkey.should == '666'
      end
    end
    
    describe '#is_new?' do
      it 'returns true if the user has no constructed or arena' do
        user.is_new?.should be_true
      end
      
      it 'returns false if the user has played a match' do
        create(:match, user: user)
        
        user.is_new?.should be_false
      end
    end

    describe 'charge methods' do
        describe '#update_subscription' do
          it 'should set subscription_id' do
            user.update_subscription(1)

            user.subscription_id.should == 1
          end
        end

        describe '#cancel_subscription' do
          it 'should set subscription_id to nil' do
            user.update_subscription(1)
            user.cancel_subscription
            
            user.subscription_id.should == nil
          end
        end
    end
  end
end
