require 'spec_helper'
require 'kickboxer/person'

describe Kickboxer::Person do
  it 'looks up a person by email address' do
    stub_response('person-email')
    response = Kickboxer::Person.find_by_email('bart@fullcontact.com')

    response.status_code.should eq 200
    response.contactInfo.familyName.should eq 'Lorang'
    response.contactInfo.givenName.should eq 'Bart'
    response.contactInfo.websites.length.should eq 4
    response.contactInfo.chats.length.should eq 2
    response.photos.length.should eq 26
    response.demographics.age.should eq '32'
    response.demographics.locationGeneral.should eq 'Boulder, Colorado'
    response.demographics.gender.should eq 'Male'
    topics = response.digitalFootprint.topics.map{|topic| topic['value'] }
    topics.should include 'entrepreneurship'
    topics.should include 'tequila'
    topics.should include 'tim tebow'
    twitter = response.socialProfiles.detect{|p| p['type'] == 'twitter' }
    twitter['url'].should eq 'http://www.twitter.com/lorangb'
    organizations = response.organizations.map{|o| o['name'] }
    organizations.should include 'FullContact'
    organizations.should include 'Techstars'
    organizations.should include 'Rainmaker Technologies'
  end

  it 'looks up a person by phone number' do
    stub_response('person-phone')
    response = Kickboxer::Person.find_by_phone_number('+13037170414')

    response.status_code.should eq 200
    response.contactInfo.familyName.should eq 'Lorang'
    response.contactInfo.givenName.should eq 'Bart'
    response.contactInfo.websites.length.should eq 5
    response.contactInfo.chats.length.should eq 2
    response.photos.length.should eq 24
    response.demographics.age.should eq '32'
    response.demographics.locationGeneral.should eq 'Denver, Colorado, United States'
    response.demographics.gender.should eq 'male'
    topics = response.digitalFootprint.topics.map{|topic| topic['value'] }
    topics.should include 'entrepreneurship'
    topics.should include 'tequila'
    topics.should include 'tim tebow'
    twitter = response.socialProfiles.detect{|p| p['type'] == 'twitter' }
    twitter['url'].should eq 'http://www.twitter.com/lorangb'
    organizations = response.organizations.map{|o| o['name'] }
    organizations.should include 'FullContact'
  end

  it 'looks up a person by twitter username' do
    stub_response('person-twitter')
    response = Kickboxer::Person.find_by_twitter('lorangb')

    response.status_code.should eq 200
    response.contactInfo.familyName.should eq 'Lorang'
    response.contactInfo.givenName.should eq 'Bart'
    response.contactInfo.websites.length.should eq 2
    response.photos.length.should eq 7
    response.demographics.locationGeneral.should eq 'Boulder, Colorado'
    response.demographics.gender.should eq 'male'
    topics = response.digitalFootprint.topics.map{|topic| topic['value'] }
    topics.should include 'angel investing'
    topics.should include 'technology'
    topics.should include 'tim tebow'
    twitter = response.socialProfiles.detect{|p| p['type'] == 'twitter' }
    twitter['url'].should eq 'http://www.twitter.com/lorangb'
    organizations = response.organizations.map{|o| o['name'] }
    organizations.should include 'FullContact'
  end

  it 'looks up a person by facebook username' do
    stub_response('person-facebook')
    response = Kickboxer::Person.find_by_facebook('bart.lorang')

    response.status_code.should eq 200
    response.contactInfo.familyName.should eq 'Lorang'
    response.contactInfo.givenName.should eq 'Bart'
    response.contactInfo.websites.length.should eq 1
    response.photos.length.should eq 3
    response.demographics.gender.should eq 'male'
    twitter = response.socialProfiles.detect{|p| p['type'] == 'twitter' }
    twitter['url'].should eq 'http://twitter.com/lorangb'
  end
end
