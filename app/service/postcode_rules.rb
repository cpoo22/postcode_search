class PostcodeRules

  CONFIG_PATH = 'config/postcode_rules.yml'

  def initialize(path = CONFIG_PATH)
    @path = path
  end

  def allow?(postcode)
    true
  end

  def prefixes
    @prefixes ||= YAML.load_file(Rails.root.join(@path))['lsoa_prefixes']
  end
end
