require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email" do
    let(:user) { FactoryBot.create(:user) }  # Create a user instance using FactoryBot
    
    it "sends a welcome email to the user" do
      mail = UserMailer.welcome_email(user)
      
      expect(mail.subject).to eq('Bienvenue chez nous !')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['sbellotlecoq@gmail.com'])

    end
  end

  # describe "order_confirmation_email" do
  #   let(:user) { FactoryBot.create(:user) }
  #   let(:item) { FactoryBot.create(:item) }
  #   let(:cart) { FactoryBot.create(:cart, user: user) }
  #   let(:line_item) { FactoryBot.create(:line_item, item: item, cart: cart) }
  #   let(:order) { FactoryBot.create(:order, user: user) }
  
  #   it "sends an order confirmation email to the user after filling the order" do
  #     expect {
  #       order.fill_order(cart) # Fill the order before the email is sent
  #     }.to change { ActionMailer::Base.deliveries.count }.by(1) # Ensure that an email is sent
  
  #     mail = ActionMailer::Base.deliveries.last # Get the last sent email
  
  #     expect(mail.subject).to eq('Récapitulatif de votre commande')
  #     expect(mail.to).to eq([order.user.email])
  #     expect(mail.from).to eq(['sbellotlecoq@gmail.com'])
  #   end
  # end
  

end
