require 'rails_helper'

RSpec.describe Cart, type: :model do
  before(:each) do 
    # en général, tu as envie de créer une nouvelle instance
    @cart = FactoryBot.create(:cart)  
    end
  
    context "validations" do
      it "has a valid factory" do
        # teste toujours tes factories pour voir si elles sont valides
        expect(build(:cart)).to be_valid
      end

      it "is valid with valid attributes" do
        expect(@cart).to be_a(Cart)
      end

      describe "#some_attribute" do
        # teste cet attribut, en fonction de la validation que tu lui as donnée
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
