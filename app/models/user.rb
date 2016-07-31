class User < ApplicationRecord
  has_secure_password
  
  # callbacks
  before_save { self.email = email.downcase }
  
  # name validations
  validates :name,
    presence: true, 
    length: { maximum: 50}

  # email validations
  # /	start of regex
  #   \A	match start of a string
  #   [\w+\-.]+	at least one word character, plus, hyphen, or dot
  #   @	literal “at sign”
  #   [a-z\d\-.]+	at least one letter, digit, hyphen, or dot
  #   (\.[a-z\d\-]+)* a dot followed by at least one letter, digit, hyphen zero or more times
  #   \.	literal dot
  #   [a-z]+	at least one letter
  #   \z	match end of a string
  # /	end of regex
  # i	case-insensitive
  VALID_EMAIL_REGEX = %r{\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z}i
  
  validates :email,
    uniqueness: { case_sensitive: false },
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }
  
  validate :password_complexity

  def password_complexity
    return if password.nil?
  
    if password.size < 8
      errors.add :password, "Must be at least 8 characters long."
      return
    end
  
    required_complexity = 3 # we're actually storing this in the configuration of each customer
  
    if !CheckPasswordComplexityService.new(password, required_complexity).valid?
      errors.add :password, "Your password does not match the security requirements."
    end
  end
end

class CheckPasswordComplexityService

  attr_reader :password, :required_complexity

  def initialize(password, required_complexity)
    @password = password
    @required_complexity = required_complexity
  end

  def valid?
    score = has_uppercase_letters? + has_digits? + has_extra_chars? + has_downcase_letters?

    score >= required_complexity
  end

  private

  def has_uppercase_letters?
    password.match(/[A-Z]/) ? 1 : 0
  end

  def has_digits?
    password.match(/\d/) ? 1 : 0
  end

  def has_extra_chars?
    password.match(/\W/) ? 1 : 0
  end

  def has_downcase_letters?
    password.match(/[a-z]{1}/) ? 1 : 0
  end
end