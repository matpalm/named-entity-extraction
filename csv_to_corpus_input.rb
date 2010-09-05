#!/usr/bin/env ruby

class String

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

end

STDIN.each do |line|
  next if line =~ /^messageID/

  fields = line.split("\t")
  msg_id, body = [0,7].map{|i| fields[i]}

  body = body.
    duplicate_spaces_removed.
    duplicate_punctuation_removed

  puts "#{msg_id}. #{body}"
  puts # require a new line to denote new paragraph
end
