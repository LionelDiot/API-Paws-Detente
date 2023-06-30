require 'rails_helper'

RSpec.describe LineItem, type: :model do
  before(:each) do 
    # en général, tu as envie de créer une nouvelle instance
    @line_item = FactoryBot.create(:line_item)   
    end
  
    context "validations" do
      it "has a valid factory" do
        # teste toujours tes factories pour voir si elles sont valides
        expect(build(:line_item)).to be_valid
      end
      
      it "is valid with valid attributes" do
        expect(@line_item).to be_a(LineItem)
      end
  


      describe "#quantity" do
        it { expect(@line_item).to validate_presence_of(:quantity) }
      end
  
    end
  
    context "associations" do
  
      it { expect(FactoryBot.create(:line_item)).to belong_to(:cart) }
      it { expect(FactoryBot.create(:line_item)).to belong_to(:item) }
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
