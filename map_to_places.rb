#!/usr/bin/env ruby
require 'rubygems'
require 'ferret'

include Ferret
index = Index::Index.new()

require 'csv'
File.open('test').each do |line|
  next if line =~ /^ID/
  cols = CSV::parse_line(line)
  id,taxo,name = cols[0],cols[1],cols[2]
  next if taxo == name
  continent = taxo.gsub(/ -\>.*/,'')
  index << { :id => id, :continent => continent, :name => name }
  puts "DOC #{id} #{continent} #{name}"
end

STDIN.each do |line|
  query = line.chomp
  hits = index.search(query).hits
  if hits.empty?
    puts "#{query.class} no results"
  else
    hits.each do |hit|
      puts "#{query.class} score #{hit.score} doc #{index[hit.doc].load.inspect}"
    end
  end
end
