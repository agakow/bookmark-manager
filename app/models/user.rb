require 'bcrypt'
require 'dm-validations'

class User
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id,    Serial
  property :name,  String
  property :email,  String, format: :email_address, required: true
  property :password_digest, String, length: 60

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, as: :email_address

  def error_messages
    ["Please enter an email address",
      "Please enter a valid email address",
      "Your passwords don't match"]
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
