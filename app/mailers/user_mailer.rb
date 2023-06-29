class UserMailer < ApplicationMailer
  default from: 'sbellotlecoq@gmail.com'    

  def welcome_email(user)               
    @user = user                                                         
    @url  = 'http://monsite.fr/login'                                    
    mail(to: @user.email, subject: 'Bienvenue chez nous !')            
  end

  def purchase_email(order)
		@order = order
		@order_items = @order.order_items
		mail(to: @order.user.email, subject: 'Récapitulatif de votre commande')
	end

end
