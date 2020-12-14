#! /usr/bin/env ruby

inputs = File.read('13-input.txt').split
inputs = [
  '939',
  '7,13,x,x,59,x,31,19',
]

def pp(results)
  puts results.map {|r| r ? '🍏' : '🍎'}.join(' ')
end

offsets = inputs[1].split(',').map.with_index { |bus, offset|
  { bus: bus.to_i, offset: offset }
}.reject {|o| o[:bus] == 0}

def start_time(time, step, interval)
  i = 0
  loop do
    return time + i - interval if (time + i) % step == 0
    i += 1
  end
end

start = 300_000_000_000_000

def find_step(step, o)
  time = step
  loop do
    #require 'pry'; binding.pry if o[:bus] == 59
    if (time + o[:offset]) % o[:bus] == 0
      return time
    end
    time += step
  end
end

step = 1
time = 0
step = offsets.reduce(1) { |acc, o|
  if o[:offset] == 0
    o[:bus]
  else
    require 'pry'; binding.pry
    find_step(acc, o)
  end
}

require 'pry'; binding.pry

loop do
  #puts time if time % 1_000_000 == 0
  time += step
  result = offsets.map {|o|
    (time + o[:offset]) % o[:bus] == 0
  }

  if result.uniq == [true]
    puts time
    require 'pry'; binding.pry
    exit
  end
end
