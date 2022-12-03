#! /usr/bin/env ruby

require_relative '16/parser'
require_relative '16/packet'

input = File.read('16-input.txt')
#input = 'C200B40A82' # => 3
#input = '04005AC33890' # => 54
#input = '880086C3E88112' # => 7
#input = 'CE00C43D881120' # => 9
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
total_sum = version_sum + sum(result[:subpackets])

packet = Packet.new(result)
puts packet.run
