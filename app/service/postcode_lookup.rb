# frozen_string_literal: true

require 'net/http'

class PostcodeLookup
  def clean_postcode(postcode)
    postcode.downcase.gsub(/\s+/, '')
  end
end
