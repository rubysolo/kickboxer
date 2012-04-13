# Kickboxer

Kickboxer is a wrapper around the FullContact API

## Installation

Add this line to your application's Gemfile:

    gem 'kickboxer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kickboxer

## Usage

The Full Contact API requires an API key.  Register for a free key at
https://www.fullcontact.com/sign-up/.  Once you receive your key, you can
configure Kickboxer to use it via:

    Kickboxer.api_key = '01234decafbad'


The following API endpoints are implemented:

+ Person
  + lookup (by email, phone number, twitter username, or facebook username)
- User
- Contact List
- Contact
- Snapshot
- Subscription
+ Name
  + normalize
  + deduce
  + similarity
  + stats
  + parser
- Icon
- Provisioning
- Batch Process

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
