#! /usr/bin/env ruby

input = '364289715'.split('').map(&:to_i)
#input = '389125467'.split('').map(&:to_i)
length = input.length

$debug = false

current_cup = input[0]
100.times do |i|
  picked_up = []

  if $debug
    puts "-- move #{i + 1} --"
    puts "cups: #{input.inspect}"
    puts "current cup: #{current_cup}"
  end

  3.times do |i|
    picked_up << input.slice!((input.index(current_cup) + 1) % input.length)
  end
  puts "pick up: #{picked_up.inspect}" if $debug

  target = current_cup - 1
  target_index = nil
  loop do
    target_index = input.index(target)
    break if target_index

    target -= 1
    if target < input.min
      target = input.max
    end
  end
  puts "destination: #{target_index + 1}" if $debug
  input.insert(target_index + 1, picked_up)
  input.flatten!

  current_cup = input[(input.index(current_cup) + 1) % length]
end

puts input.rotate(input.index(1))[1 .. -1].join
