#!/usr/bin/env ruby
require 'message_sanitisation.rb'

STDIN.each do |line|
  next if line =~ /^messageID/

  fields = line.split("\t")
  msg_id, body = [0,7].map{|i| fields[i]}

  puts "#{msg_id}\t#{body.sanitise}"
end
