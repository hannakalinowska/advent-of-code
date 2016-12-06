#! /usr/bin/env ruby

require 'digest'

door_id = 'cxdnnyjw'
password = {}
n = 0

loop do
  digest = Digest::MD5.hexdigest(door_id + n.to_s)
  if digest.start_with?('00000')
    position = digest[5]
    char = digest[6]
    if position =~ /[0-7]/ && password[position].nil?
      password[position] = char
      puts password
    end
  end
  n += 1
  break if password.length == 8
end

puts password
