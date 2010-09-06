class String

  def without_embedded_links
    gsub(/\[(.*?)\|(.*?)\]/) { $1 } 
  end

  def without_bare_urls
    gsub(/http.*?\s/,' ').sub(/http.*?$/,' ')
  end

  def without_brackets
    gsub(/[\)\(]/, ' ')
  end

  def without_italics_markup 
    gsub(/\+/,' ')
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

  def sanitise
    without_embedded_links.
    without_bare_urls.
    without_brackets.
    without_italics_markup.
    duplicate_punctuation_removed.
    duplicate_spaces_removed.
    strip
  end

end
