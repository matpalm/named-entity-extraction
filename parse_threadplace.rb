#!/usr/bin/env ruby
STDIN.each do |line|
  next if line =~ /^ID/
  fields = line.split("\t")
  next unless fields[4]=='0'
  puts fields[3]
end
