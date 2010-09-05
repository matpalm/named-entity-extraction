class String

  def without_bare_urls
    gsub(/http.*?\s/,' ').sub(/http.*?$/,' ')
  end

  def duplicate_spaces_removed
    gsub("\r",' ').gsub("/n",' ').gsub("\t",' ').gsub(/\s+/,' ')
  end

  def duplicate_punctuation_removed
    str = self.clone
    '!.()[]{}|,@$%&*;:"\'\?'.chars.to_a.each do |char|
      regex = '\\' + char + '+' # weirdity ensues having this inside the actual gsub
      str.gsub!(/#{regex}/, char)
    end
    str
  end

  def without_brackets 
    # confuses tagger, which thinks they are a NNP (?)
    gsub(/[\)\(]/, ' ')
  end

  def without_embedded_links
    gsub(/\[(.*?)\|(.*?)\]/) { $1 }
  end

  def sanitise
    strip.
    without_embedded_links.
    without_bare_urls.
    without_brackets.
    duplicate_spaces_removed.
    duplicate_punctuation_removed
  end

end
