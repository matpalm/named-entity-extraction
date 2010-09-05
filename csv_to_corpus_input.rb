#!/usr/bin/env ruby
STDIN.each do |line|
  next if line =~ /^messageID/
  messageID,parentMessageID,threadID,forumID,forumIndex,userID,subject,body,modValue,rewardPoints,creationDate,modificationDate = line.split("\t")
  body = body.strip.gsub("\r",' ').gsub("/n",' ').gsub(/\s+/,' ') # remove \r since in tt output ?
  puts body
  puts # require a new line to denote new paragraph
end
