class Parser
  def to_binary(hex)
    mappings = {
      '0' => '0000',
      '1' => '0001',
      '2' => '0010',
      '3' => '0011',
      '4' => '0100',
      '5' => '0101',
      '6' => '0110',
      '7' => '0111',
      '8' => '1000',
      '9' => '1001',
      'A' => '1010',
      'B' => '1011',
      'C' => '1100',
      'D' => '1101',
      'E' => '1110',
      'F' => '1111',
    }

    hex.split('').map {|h| mappings[h]}.join
  end

  def decode(packet)
    return if packet.length < 6

    version_id = packet[0..2].to_s.to_i(2)
    packet_id = packet[3..5].to_i(2)

    remainder = nil

    result = {
      version_id: version_id,
      packet_id: packet_id,
    }

    if packet_id == 4
      return decode_literal(packet[6 .. -1], result)
    else
      length_type_id = packet[6].to_i(2)
      if length_type_id == 0
        # length is a 15-bit number representing the number of bits in the sub-packets
        length = packet[7..21].to_i(2)
        remainder = packet[22..22+length-1]
        result[:subpackets] = []
        loop do
          r, s = decode(remainder)
          result[:subpackets] << s

          if r.empty?
            break
          else
            remainder = r
          end
        end
        return [packet[22+length .. -1], result]
      else
        # length is a 11-bit number representing the number of sub-packets
        number_of_subpackets = packet[7..17].to_i(2)
        remainder = packet[18 .. -1]
        subpackets = []
        number_of_subpackets.times do
          r, s = decode(remainder)
          subpackets << s
          remainder = r
        end
        result[:subpackets] = subpackets
        return [remainder, result]
      end
    end
  end

  def decode_literal(packet, result)
    i = 0
    literal = ''
    loop do
      last = packet[i].to_i(2)
      literal += packet[i+1..i+4]

      i += 5
      break if last == 0
    end
    result[:literal] = literal.to_i(2)
    remainder = packet[i .. -1]

    [remainder, result]
  end
end
