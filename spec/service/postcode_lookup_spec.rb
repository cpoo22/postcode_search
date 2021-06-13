# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostcodeLookup do
  subject(:lookup) { described_class.new }

  context '#clean_postcode' do
    it 'removes spaces and downcases the postcode' do
      expect(lookup.clean_postcode('BN1 1AL')).to eq 'bn11al'
    end
  end
end
