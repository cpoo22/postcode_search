# frozen_string_literal: true

class PostcodeRules
  CONFIG_PATH = 'config/postcode_rules.yml'

  def initialize(path = CONFIG_PATH)
    @path = path
  end

  def allow?(postcode)
    result = PostcodeLookup.lsoa(postcode: postcode)
    return true if result == 'Postcode not found'

    prefixes.any? { |prefix| result.start_with?(prefix) }
  end

  def prefixes
    @prefixes ||= YAML.load_file(Rails.root.join(@path))['lsoa_prefixes']
  end
end
