#! /usr/bin/env ruby

require_relative '16/parser'

input = File.read('16-input.txt')
#input = '8A004A801A8002F478'

parser = Parser.new

remainder, result = parser.decode(parser.to_binary(input))
version_sum = result[:version_id]

def sum(subpackets)
  version_sum = 0
  subpackets.each do |subpacket|
    version_sum += subpacket[:version_id]
    version_sum += sum(subpacket[:subpackets]) if subpacket[:subpackets]
  end
  version_sum
end

puts version_sum + sum(result[:subpackets])
