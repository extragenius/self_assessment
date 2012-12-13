module TranslationExtractor
  def self.to_language_attributes(data)
    locales = data.keys
    locales.each do |locale| 
      hash_walker(data[locale])
      processed_data.each do |key, value|
        attributes << {
          locale: locale,
          key: key,
          value: value
        }
      end
      @processed_data = nil
    end
    return attributes
  end
  
  def self.hash_walker(hash, parent = nil)
    if hash.kind_of? Hash
      hash.each do |key, value|
        path = [parent, key.to_s].compact.join('.')
        hash_walker(value, path)
      end
    else
      processed_data[parent] = hash 
    end
  end
  
  def self.processed_data
    @precessed_data ||= Hash.new
  end
  
  def self.attributes
    @attributes ||= Array.new
  end
  
end
