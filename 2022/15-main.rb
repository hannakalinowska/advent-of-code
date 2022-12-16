#! /usr/bin/env ruby

require_relative '15/sensor'
require 'set'

input = File.read('15-input.txt')
#input = <<-EOF
#Sensor at x=2, y=18: closest beacon is at x=-2, y=15
#Sensor at x=9, y=16: closest beacon is at x=10, y=16
#Sensor at x=13, y=2: closest beacon is at x=15, y=3
#Sensor at x=12, y=14: closest beacon is at x=10, y=16
#Sensor at x=10, y=20: closest beacon is at x=10, y=16
#Sensor at x=14, y=17: closest beacon is at x=10, y=16
#Sensor at x=8, y=7: closest beacon is at x=2, y=10
#Sensor at x=2, y=0: closest beacon is at x=2, y=10
#Sensor at x=0, y=11: closest beacon is at x=2, y=10
#Sensor at x=20, y=14: closest beacon is at x=25, y=17
#Sensor at x=17, y=20: closest beacon is at x=21, y=22
#Sensor at x=16, y=7: closest beacon is at x=15, y=3
#Sensor at x=14, y=3: closest beacon is at x=15, y=3
#Sensor at x=20, y=1: closest beacon is at x=15, y=3
#EOF
input = input.split("\n")

min_x = 0
min_y = 0
max_x = 4_000_000
max_y = 4_000_000
#max_x = 20
#max_y = 20

def pretty_print(sensors)
  max_range = sensors.map {|s| s.range}.max
  min_x = sensors.map {|s| s.sensor_x}.min - max_range
  max_x = sensors.map {|s| s.sensor_x}.max + max_range
  min_y = sensors.map {|s| s.sensor_y}.min - max_range
  max_y = sensors.map {|s| s.sensor_y}.max + max_range

  sensor_positions = sensors.map {|s| [s.sensor_x, s.sensor_y]}
  beacon_positions = sensors.map {|s| [s.beacon_x, s.beacon_y]}

  (min_x .. max_x).each do |x|
    print "%2d " % x
    (min_y .. max_y).each do |y|
      case
      when sensor_positions.include?([x,y])
        print 'S'
      when beacon_positions.include?([x,y])
        print 'B'
      else
        s = sensors.find {|s| s.contains?(x, y)}
        s ? print('#') : print('.')
      end
    end
    puts
  end
end


sensors = []
filled_spaces = Set.new

input.each do |line|
  line =~ /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/

  sensors << Sensor.new($1.to_i, $2.to_i, $3.to_i, $4.to_i)
  filled_spaces << [$1.to_i, $2.to_i] # sensor is here
  filled_spaces << [$3.to_i, $4.to_i] # beacon is here
end

t = Time.now
(min_x .. max_x).each do |x|
  if x % 10_000 == 0
    puts "#{x}, #{Time.now - t}"
    t = Time.now
  end
  line = sensors.map {|s| s.y_range(x) }
    .compact
    .sort
  coverage = line.shift
  line.each do |start, finish|
    if start < coverage.first && coverage.first <= finish
      coverage.first = start
    end
    if start <= coverage.last && coverage.last < finish
      coverage[1] = finish
    end
    if coverage.last < start
      puts (coverage.last + 1) * 4_000_000 + x
      exit
    end
  end
end
