# frozen_string_literal: true

require 'net/http'

class PostcodeLookup
  def self.lsoa(postcode:)
    cleaned_postcode = clean_postcode(postcode)
    result = call_api(cleaned_postcode)
    extract_lsoa(result)
  end

  def self.clean_postcode(postcode)
    postcode.downcase.gsub(/\s+/, '')
  end

  def self.call_api(postcode)
    uri = URI("http://postcodes.io/postcodes/#{postcode}")

    JSON.parse(Net::HTTP.get_response(uri).body)
  end

  def self.extract_lsoa(res)
    if res['status'] == 200
      res['result']['lsoa']
    elsif res['status'] == 404 && res['error'] == 'Postcode not found'
      'Postcode not found'
    end
  end
end
