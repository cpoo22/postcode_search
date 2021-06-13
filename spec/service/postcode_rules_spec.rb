# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeRules do
  subject(:rules) { described_class.new }

  let(:allowed_postcode) { 'SE1 7QD' }
  let(:unfound_postcode) { 'SH24 1AA' }
  let(:not_allowed_postcode) { 'BN1 1AL' }

  it 'allows a postcode if it is in an allowed LSOA' do
    allow(PostcodeLookup).to receive(:lsoa).and_return('Southwark 034A')
    expect(rules.allow?(allowed_postcode)).to be true
  end

  it 'allows a postcode if it is unfound' do
    allow(PostcodeLookup).to receive(:lsoa).and_return('Postcode not found')
    expect(rules.allow?(unfound_postcode)).to be true
  end

  it 'doesnt allow a postcode if it is in NOT an allowed LSOA' do
    allow(PostcodeLookup).to receive(:lsoa).and_return('Brighton 123A')
    expect(rules.allow?(not_allowed_postcode)).to be false
  end

  it 'loads the config file correctly' do
    expect(described_class.new('spec/fixtures/postcode_rules.yml').prefixes).to eq %w[disneyland shire]
  end
end
