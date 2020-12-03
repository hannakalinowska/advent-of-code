#! /usr/bin/env ruby

inputs = File.read('03-input.txt').split('')

houses = {'0:0' => 2}

Position = Struct.new(:x, :y) do
  def to_s
    "#{x}:#{y}"
  end
end

santa_position = Position.new(0, 0)
robo_santa_position = Position.new(0, 0)

def move(m, position)
  case m
  when '^'
    position.x += 1
  when 'v'
    position.x -= 1
  when '>'
    position.y -= 1
  when '<'
    position.y += 1
  end
  position
end

inputs.each_with_index do |m, index|
  if index % 2 == 0
    # santa moves
    santa_position = move(m, santa_position)

    houses[santa_position.to_s] ||= 0
    houses[santa_position.to_s] += 1
  else
    # robo santa moves
    robo_santa_position = move(m, robo_santa_position)

    houses[robo_santa_position.to_s] ||= 0
    houses[robo_santa_position.to_s] += 1
  end
end

puts houses.keys.count
