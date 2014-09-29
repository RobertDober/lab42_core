module AE
  # Access project metadata.
  #
  # @return [Hash]
  def self.metadata
    @metadata ||= (
      require 'yaml'
      YAML.load(File.new(File.dirname(__FILE__) + '/../ae.yml'))
    )
  end

  #
  def self.const_missing(name)
    key = name.to_s.downcase
    metadata[key] || super(name)
  end

  # Becuase Ruby 1.8~ gets in the way :(
  VERSION = metadata['version']
end

