#! /usr/bin/env ruby

input = File.read('06-input.txt').split("\n")

lines = input.map do |line|
  line =~ /^(turn off|turn on|toggle) (\d+),(\d+) through (\d+),(\d+)$/
  {action: $1, start_x: $2.to_i, start_y: $3.to_i, end_x: $4.to_i, end_y: $5.to_i}
end

lights = Array.new(1000) { Array.new(1000, 0) }

lines.each do |line|
  (line[:start_x] .. line[:end_x]).each do |x|
    (line[:start_y] .. line[:end_y]).each do |y|
      case line[:action]
      when "turn on"
        lights[x][y] += 1
      when "turn off"
        lights[x][y] > 0 ? lights[x][y] -= 1 : lights[x][y]
      when "toggle"
        lights[x][y] += 2
      end
    end
  end
end

puts lights.flatten.sum {|l| l }
