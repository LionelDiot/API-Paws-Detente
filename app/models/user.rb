class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :items
  has_one :cart, dependent: :destroy

  devise :database_authenticatable, :registerable,
	  :jwt_authenticatable, :recoverable,
	  jwt_revocation_strategy: JwtDenylist

  after_create :welcome_email, :create_cart

  def welcome_email
    UserMailer.welcome_email(self).deliver_now            
  end 

  def create_cart
    Cart.create!(
      user_id: self.id
    )
  end
end
