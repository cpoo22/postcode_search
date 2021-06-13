# frozen_string_literal: true

require 'net/http'

class PostcodeLookup
  def clean_postcode(postcode)
    postcode.downcase.gsub(/\s+/, '')
  end

  def extract_lsoa(res)
    if res['status'] == 200
      res['result']['lsoa']
    elsif res['status'] == 404 && res['error'] == 'Postcode not found'
      'Postcode not found'
    end
  end
end
