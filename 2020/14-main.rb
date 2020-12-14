#! /usr/bin/env ruby

inputs = File.read('14-input.txt').split("\n")
#inputs = [
#  'mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X',
#  'mem[8] = 11',
#  'mem[7] = 101',
#  'mem[8] = 0',
#]

mask = nil
mem = {}

def masked(value, mask)
  -1.downto(-mask.length).reduce([]) {|acc, i|
    character = (mask[i] == 'X' ? (value[i] || 0) : mask[i])
    acc << character
    acc
  }
    .reverse
    .join
    .to_i(2)
end

inputs.each do |line|
  if line =~ /mask = ([X01]+)/
    mask = $1.split('')
  else
    line =~ /mem\[(\d+)\] = (\d+)/
    id = $1
    value = $2.to_i.to_s(2).split('')

    mem[id] = masked(value, mask)
  end
end

puts mem.values.reduce(&:+)
