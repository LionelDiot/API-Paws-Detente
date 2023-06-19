class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
	  :jwt_authenticatable,
	  jwt_revocation_strategy: JwtDenylist

  after_create :welcome_email
  def welcome_email
    UserMailer.welcome_email(self).deliver_now            
  end 

end
