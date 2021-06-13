# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeLookup do
  subject(:lookup) { described_class }

  let(:allowed_postcode) { 'SE1 7QD' }
  let(:unfound_postcode) { 'SH24 1AA' }

  let(:unfound_result) { { 'status' => 404, 'error' => 'Postcode not found' } }
  let(:found_result) { { 'status' => 200, 'result' => { 'postcode' => 'SE1 7QD', 'lsoa' => 'Southwark 034A' } } }

  context '#losa' do
    it 'returns the lsoa for a known postcode' do
      expect(lookup.lsoa(postcode: allowed_postcode)).to eq 'Southwark 034A'
    end

    it 'returns the error message for an unfound postcode' do
      expect(lookup.lsoa(postcode: unfound_postcode)).to eq 'Postcode not found'
    end
  end

  context '#clean_postcode' do
    it 'removes spaces and downcases the postcode' do
      expect(lookup.clean_postcode('BN1 1AL')).to eq 'bn11al'
    end
  end

  context '#extract_lsoa' do
    it 'extracts the lsoa if found' do
      expect(lookup.extract_lsoa(found_result)).to eq 'Southwark 034A'
    end

    it 'returns a not found message if not found' do
      expect(lookup.extract_lsoa(unfound_result)).to eq 'Postcode not found'
    end
  end

  context '#call_api' do
    it 'returns a valid result' do
      result = lookup.call_api('se17qd')
      expect(result.keys).to eq %w[status result]
      expect(result['result']['lsoa']).to eq 'Southwark 034A'
    end
  end
end
