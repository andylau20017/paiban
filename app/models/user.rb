require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :username, :email, :salt, :hashed_password, :company, :profile, :password, :password_confirmation
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password

  validate  :password_must_be_present
  
  validates_length_of :username, :within => 3..64
  validates_length_of :email, :within => 5..128  
  validates_length_of :company, :within => 0..100
  validates_length_of :password, :within => 4..20
  validates_length_of :profile, :maximum => 1000
  
  def User.authenticate(name, password)
    if user = find_by_username(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end
  
  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
  private

    def password_must_be_present
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
  
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end