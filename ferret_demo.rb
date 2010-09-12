#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'ferret'

index = Ferret::Index::Index.new()

african_places = ['Aïn Sefra','Algeria','Algiers','South Algiers','Batna','Batni']
african_places.each do |name| 
  puts "adding place [#{name}] to index"
  index << { :continent => :africa, :name => name } 
end
european_places = ['Paris','London','Batni']
european_places.each do |name| 
  puts "adding place [#{name}] to index"
  index << { :continent => :europe, :name => name } 
end

puts "simple search, returning document index"
@index.search("europe").hits.each { |hit| puts hit.doc.inspect }
puts @index[7].load.inspect

puts 'simple term search'
index.search('name:algiers').hits.each do |hit| 
  puts "score=#{hit.score} doc=#{@index[hit.doc].load.inspect}"
end

puts 'simple wildcard'
index.search('name:ba*').hits.each do |hit| 
  puts "score=#{hit.score} doc=#{@index[hit.doc].load.inspect}"
end

puts 'character normalisation'
index.search('name:ain sefra').hits.each do |hit| 
  puts "score=#{hit.score} doc=#{@index[hit.doc].load.inspect}"
end

puts 'fuzzy'
index.search('name:bitna~0.4').hits.each do |hit| 
  puts "score=#{hit.score} doc=#{@index[hit.doc].load.inspect}"
end

puts 'boolean'
index.search('continent:africa AND name:bitna~').hits.each do |hit| 
  puts "score=#{hit.score} doc=#{@index[hit.doc].load.inspect}"
end

