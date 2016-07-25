class User < ApplicationRecord
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
      presence: true,
      length: { maximum: 255},
      format: { with: VALID_EMAIL_REGEX }
end