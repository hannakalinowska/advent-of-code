#! /usr/bin/env ruby

inputs = File.read('13-input.txt').split
#inputs = [
#  '939',
#  '7,13,x,x,59,x,31,19',
#]

def pp(results)
  puts results.map {|r| r ? '🍏' : '🍎'}.join(' ')
end

offsets = inputs[1].split(',').map.with_index { |bus, offset|
  { bus: bus.to_i, offset: offset }
}.reject {|o| o[:bus] == 0}

shared = offsets.reduce({}) { |acc, o|
  if acc.empty?
    acc = o
  else
    (acc[:offset] .. (acc[:bus] * o[:bus])).step(acc[:bus]) do |time|
      if (time + o[:offset]) % o[:bus] == 0
        acc[:offset] = time
        acc[:bus] = acc[:bus] * o[:bus]
        break
      end
    end
  end
  puts acc.inspect
  acc
}

puts shared[:offset]
