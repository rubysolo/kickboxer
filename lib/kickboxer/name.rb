require 'kickboxer/request'
require 'kickboxer/response'

module Kickboxer
  class Name
    # Public: The Name Normalization method takes quasi structured name data
    # provided as a string and outputs the data in a structured manner. It also
    # returns a likelihood based only on the order of the given name and family
    # name as seen in the US population.
    #
    # full_name - a string containing the full name.  Can include standard
    #             prefix, first name, nickname, middle name, last name, and
    #             suffix.
    #
    # Example
    #
    #   response = Kickboxer::Name.normalize('Mr. John (Johnny) Michael Smith')
    #   response.nameDetails.givenName
    #   # => 'John'
    #   response.nameDetails.familyName
    #   # => 'Smith'
    def self.normalize(full_name)
      Request.run('name/normalizer', q: full_name)
    end

    # Public: The Name Deducer method takes a username or email address
    # provided as a string and attempts to deduce a structured name. It also
    # returns a likelihood based on US population data. This method is ideal
    # for business email addresses due to the use of standard convention in
    # corporate email address formats.
    #
    # options - a hash containing the email or username to be interpreted.
    #           :email - the email address
    #           :username - the username
    #           either :email or :username must be populated
    #
    # Example
    #
    #   response = Kickboxer::Name.deduce(username: 'johndsmith79')
    #   response.nameDetails.givenName
    #   # => 'John'
    #   response.nameDetails.familyName
    #   # => 'Smith'
    def self.deduce(options={})
      require_any_key options, :email, :username
      Request.run('name/deducer', options)
    end

    # Public: The Name Similarity endpoint compares two names and returns a
    # score indicating how similar they are. As the performance of different
    # similarity algorithms can vary over different data sets, the endpoint
    # provides 3 separate choices.
    #
    # first  - a string containing the first name to compare
    # second - a string containing the second name to compare
    #
    # Example
    #
    #   response = Kickboxer::Name.similarity('john', 'johnathan')
    #   response.result.SimMetrics.jaroWinkler.similarity
    #   # => 0.8889
    #   response.result.SecondString.jaroWinkler.similarity
    #   # => 0.8889
    #   response.result.FullContact.BigramAnalysis.dice.similarity
    #   # => 0.5454545455
    def self.similarity(first, second)
      Request.run('name/similarity', q1: first, q2: second)
    end

    # Public: The Name Stats method has a variety of parameters that can be
    # used to determine more about a name. See the Full Contact documentation
    # page (http://www.fullcontact.com/docs/?category=name) for a list of
    # available statistics.
    #
    # options - a hash containing the name or name parts to be examined.
    #           :givenName  - contains a name believed to be a first name.
    #           :familyName - contains a name believed to be a last name.
    #           :name       - contains a name of unknown type.
    #           At least one of the above must be provided.  Both given and
    #           family name can be provided, if available.
    #
    # Example
    #
    #   response = Kickboxer::Name.stats(name: 'john')
    #   response.name.given.likelihood     # likelihood this is a given name
    #   # => 0.992
    #   response.name.family.likelihood    # likelihood this is a family name
    #   # => 0.008
    def self.stats(options={})
      require_any_key options, :name, :givenName, :familyName
      Request.run('name/stats', options)
    end

    # Public: The Name Parser method can be used when you have two names but
    # don't know which one is the first name and which is the last name.
    #
    # full_name - a string containing the full name in unknown order
    #
    # Example
    #
    #   response = Kickboxer::Name.parse('smith john')
    #   response.result.givenName
    #   # => 'John'
    #   response.result.familyName
    #   # => 'Smith'
    #   response.result.likelihood
    #   # => 1
    def self.parse(full_name)
      Request.run('name/parser', q: full_name)
    end

    private

    def self.require_any_key(options, *keys)
      raise "#{ keys.map{|k| ":#{ k }" }.join(' or ') } required" if (options.keys && keys).empty?
    end
  end
end
