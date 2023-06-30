require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do 
    # en général, tu as envie de créer une nouvelle instance
    @item = FactoryBot.create(:item)   
    end
  
    context "validations" do
      it "has a valid factory" do
        # teste toujours tes factories pour voir si elles sont valides
        expect(build(:item)).to be_valid
      end
     
      it "is valid with valid attributes" do
        expect(@item).to be_a(Item)
      end
  
      describe "#title" do
        it { expect(@item).to validate_presence_of(:title) }
      end

      describe "#description" do
        it { expect(@item).to validate_presence_of(:description) }
      end

      describe "#price" do
        it { expect(@item).to validate_presence_of(:price) }
      end
  
    end
  
    context "associations" do
  
      it { expect(FactoryBot.create(:item)).to have_many(:line_items) }
  
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
