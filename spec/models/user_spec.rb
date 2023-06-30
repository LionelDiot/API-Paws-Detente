require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do 
    # en général, tu as envie de créer une nouvelle instance
    @user = FactoryBot.create(:user)   
    end
  
    context "validations" do
      it "has a valid factory" do
        # teste toujours tes factories pour voir si elles sont valides
        expect(build(:user)).to be_valid
      end
      
      it "is valid with valid attributes" do
        expect(@user).to be_a(User)
      end
  
      describe "#email" do
        it { expect(@user).to validate_presence_of(:email) }
      end
  
    end
  
    context "associations" do
  
      describe "some association" do
        # teste cette association
      end
  
    end
  
    context "callbacks" do
  
      describe "some callbacks" do
        # teste ce callback
      end
  
    end
  
    context "public instance methods" do
  
      describe "#some_method" do
        # teste cette méthode
      end
  
    end
  
    context "public class methods" do
  
      describe "self.some_method" do
        # teste cette méthode
      end
      
    end
    
end
