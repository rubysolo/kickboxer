require 'spec_helper'
require 'kickboxer/name'

describe Kickboxer::Name do
  it 'returns a normalized name' do
    stub_response('name-normalize')
    response = Kickboxer::Name.normalize('Mr. John (Johnny) Michael Smith Jr.')

    response.status_code.should eq 200
    response.status_text.should eq 'OK'

    response.likelihood.should eq 0.815
    response.region.should eq 'USA'

    details = response.nameDetails
    details.givenName.should eq 'John'
    details.familyName.should eq 'Smith'
    details.middleNames.should eq %w( Michael )
    details.prefixes.should eq %w( Mr. )
    details.suffixes.should eq %w( Jr. )
    details.nicknames.should eq %w( Johnny )
    details.fullName.should eq 'John Michael Smith'
  end

  it 'deduces real name from email' do
    stub_response('name-deduce-email')
    response = Kickboxer::Name.deduce(email: 'johndsmith79@gmail.com')

    response.status_code.should eq 200
    response.status_text.should eq 'OK'

    response.likelihood.should eq 0.665
    response.region.should eq 'USA'

    details = response.nameDetails
    details.givenName.should eq 'John'
    details.familyName.should eq 'Smith'
    details.middleNames.should eq %w( D. )
    details.fullName.should eq 'John D. Smith'
  end

  it 'calculates the similarity between two names' do
    stub_response('name-similarity')
    response = Kickboxer::Name.similarity('john', 'johnathan')

    response.status_code.should eq 200
    response.status_text.should eq 'OK'

    result = response.result
    sim_metrics = result.SimMetrics

    jaro_winkler = sim_metrics.jaroWinkler
    sprintf('%.4f', jaro_winkler.similarity).should eq '0.8889'
    sprintf('%.4f', jaro_winkler.timeEstimated).should eq '0.0016'
    jaro_winkler.timeActual.should eq 0

    levenshtein = sim_metrics.levenshtein
    sprintf('%.4f', levenshtein.similarity).should eq '0.4444'
    sprintf('%.4f', levenshtein.timeEstimated).should eq '0.0065'
    levenshtein.timeActual.should eq 0

    second_string = result.SecondString

    jaro_winkler = second_string.jaroWinkler
    sprintf('%.4f', jaro_winkler.similarity).should eq '0.8889'
    jaro_winkler.timeTaken.should eq "1 ms"

    result.FullContact.BigramAnalysis.dice.similarity.should eq 0.5454545455
  end

  it 'returns statistics for an ambiguous name' do
    stub_response('name-stats-ambiguous')
    response = Kickboxer::Name.stats(name: 'john')

    response.status_code.should eq 200
    response.status_text.should eq 'OK'

    response.name.given.likelihood.should eq 0.992
    response.name.given.rank.should eq 3
    response.name.given.male.likelihood.should eq 0.996
    response.name.given.female.likelihood.should eq 0.004

    response.name.family.likelihood.should eq 0.008
  end

  it 'returns statistics for a given name' do
    stub_response('name-stats-given')
    response = Kickboxer::Name.stats(givenName: 'john')

    response.status_code.should eq 200
    response.status_text.should eq 'OK'

    response.name.given.should_not respond_to(:likelihood)
    response.name.given.rank.should eq 3
    response.name.given.male.likelihood.should eq 0.996
    response.name.given.female.likelihood.should eq 0.004

    response.name.should_not respond_to(:family)
  end

  it 'returns statistics for a family name' do
    stub_response('name-stats-family')
    response = Kickboxer::Name.stats(familyName: 'smith')

    response.status_code.should eq 200
    response.status_text.should eq 'OK'

    response.name.family.should_not respond_to(:likelihood)
    response.name.family.rank.should eq 1

    response.name.should_not respond_to(:given)
  end

  it 'returns statistics for given and family name' do
    stub_response('name-stats-both')
    response = Kickboxer::Name.stats(givenName: 'john', familyName: 'smith')

    response.status_code.should eq 200
    response.status_text.should eq 'OK'

    response.name.family.should_not respond_to(:likelihood)
    response.name.family.rank.should eq 1

    response.name.given.should_not respond_to(:likelihood)
    response.name.given.rank.should eq 3
    response.name.given.male.likelihood.should eq 0.996
    response.name.given.female.likelihood.should eq 0.004
  end

  it 'parses full name strings into given and family names' do
    stub_response('name-parse')
    response = Kickboxer::Name.parse('john smith')

    response.status_code.should eq 200
    response.status_text.should eq 'OK'

    response.result.givenName.should eq 'John'
    response.result.familyName.should eq 'Smith'
    response.result.likelihood.should eq 1
  end
end
