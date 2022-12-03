class Packet
  def initialize(packet_id:, version_id:, literal: nil, subpackets: [])
    @packet_id = packet_id
    @version_id = version_id
    @literal = literal
    @subpackets = subpackets.map {|s| Packet.new(s)}
  end

  def run
    return @literal if @literal

    case @packet_id
    when 0
      @subpackets.map(&:run).sum
    when 1
      @subpackets.map(&:run).reduce(:*)
    when 2
      @subpackets.map(&:run).min
    when 3
      @subpackets.map(&:run).max
    when 5
      @subpackets[0].run > @subpackets[1].run ? 1 : 0
    when 6
      @subpackets[0].run < @subpackets[1].run ? 1 : 0
    when 7
      @subpackets[0].run == @subpackets[1].run ? 1 : 0
    end
  end
end
