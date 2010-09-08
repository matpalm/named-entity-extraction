#!/usr/bin/env ruby
require 'message_sanitisation.rb'

STDIN.each do |line|
  next if line =~ /^messageID/

  fields = line.split("\t")
  msg_id, body, time = [0,7,10].map{|i| fields[i]}
  body = body.sanitise

  puts "#{msg_id}\t#{time}\t#{body}" unless body.empty?
end
