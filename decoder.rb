#!/usr/bin/env ruby
# coding: utf-8

require "bundler/setup"
require "promet"
require "pp"

content = File.open("./spec/raw/events.txt","r:UTF-8") do |f|
  f.read
end

# puts
Promet::Decoder.new(content).decode


#string = '0","currentDateTime":new Date(1380278714836),"lastUpdate":new Date(1380278541490),"c'
#puts string.gsub!(/new\ Date\((?<time>\d+)\)/i,'\k<time>')
