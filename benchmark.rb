#!/usr/bin/env ruby

require 'benchmark'

require "./lib/promet"

# You could use Java's native functions for file reading! That could boost up things also!
raw_file = File.open("./spec/raw/events.txt","r:UTF-8") {|f| f.read }

puts Benchmark.measure { decoded = Promet::Decoder.decode(raw_file) }
