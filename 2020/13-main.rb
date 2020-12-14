#! /usr/bin/env ruby

inputs = File.read('13-input.txt').split
#inputs = [
#  '939',
#  '7,13,x,x,59,x,31,19',
#]

time = inputs[0].to_i
buses = inputs[1].split(',').reject{|i| i == 'x'}.map(&:to_i)

ticks = 0

loop do
  buses.each do |bus|
    if (time+ticks) % bus == 0
      puts ticks * bus
      exit
    end
  end
  ticks += 1
end
