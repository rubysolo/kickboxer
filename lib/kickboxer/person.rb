module Kickboxer
  class Person
    # Public: look up a person by email address
    #
    # email_address - a string containing the email address
    #
    # Example
    #
    #   response = Kickboxer::Person.find_by_email('bart@fullcontact.com')
    #   response.contactInfo.familyName
    #   # => 'Lorang'
    #   response.contactInfo.givenName
    #   # => 'Bart'
    #
    def self.find_by_email(email_address)
      Request.run('person', email: email_address)
    end

    # Public: look up a person by phone number
    #
    # phone_number - a string containing the phone number
    #
    # Example
    #
    #   response = Kickboxer::Person.find_by_phone_number('+13037170414')
    #   response.contactInfo.familyName
    #   # => 'Lorang'
    #   response.contactInfo.givenName
    #   # => 'Bart'
    #
    def self.find_by_phone_number(phone_number)
      Request.run('person', phone: phone_number)
    end

    # Public: look up a person by twitter username
    #
    # username - a string containing the twitter username
    #
    # Example
    #
    #   response = Kickboxer::Person.find_by_twitter('lorangb')
    #   response.contactInfo.familyName
    #   # => 'Lorang'
    #   response.contactInfo.givenName
    #   # => 'Bart'
    #
    def self.find_by_twitter(username)
      Request.run('person', twitter: username)
    end

    # Public: look up a person by facebook username
    #
    # username - a string containing the facebook username
    #
    # Example
    #
    #   response = Kickboxer::Person.find_by_facebook('bart.lorang')
    #   response.contactInfo.familyName
    #   # => 'Lorang'
    #   response.contactInfo.givenName
    #   # => 'Bart'
    #
    def self.find_by_facebook(username)
      Request.run('person', facebookUsername: username)
    end
  end
end
