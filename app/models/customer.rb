class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook,:google_oauth2,:twitter]

  has_many :cart_items, dependent: :destroy
  has_many :addresses
  has_many :customer_orders, dependent: :destroy

  after_create :send_welcome_mail

  def send_welcome_mail
    CustomerMailer.welcome_email(self).deliver  
  end
 
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |customer|
      customer.email = auth.info.email
      customer.password = Devise.friendly_token[0,20]
      customer.first_name = auth.info.name   # assuming the customer model has a name
      customer.admin = false
      # customer.image = auth.info.image # assuming the customer model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # customer.skip_confirmation!
    end 
  end
end
