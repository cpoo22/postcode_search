require 'rails_helper'

RSpec.describe ::PostcodeRules do
  subject(:rules) { described_class.new }

  let(:allowed_postcode) { 'SE1 7QD' }

  it 'allows a postcode if it is in an allowed LSOA' do
    expect(rules.allow?(allowed_postcode)).to be true
  end
end
