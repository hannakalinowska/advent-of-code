#! /usr/bin/env ruby

require 'digest'

input = 'ckczppom'
number = 0

loop do
  digest = Digest::MD5.hexdigest("#{input}#{number}")

  break if digest =~ /^000000/

  number += 1
end

puts number
