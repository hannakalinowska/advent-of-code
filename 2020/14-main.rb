#! /usr/bin/env ruby

inputs = File.read('14-input.txt').split("\n")
#inputs = [
#  'mask = 000000000000000000000000000000X1001X',
#  'mem[42] = 100',
#  'mask = 00000000000000000000000000000000X0XX',
#  'mem[26] = 1',
#]

mask = nil
mem = {}

def masked(value, mask)
  -1.downto(-mask.length).reduce([]) {|acc, i|
    character = (mask[i] == '0' ? (value[i] || 0) : mask[i])
    #puts "#{value[i]} | #{mask[i]} => #{character}"
    acc << character
    acc
  }
    .reverse
    .join
end

def permutations(id)
  return id if id !~ /X/

  one = id.sub('X', '0')
  two = id.sub('X', '1')

  [
    permutations(one),
    permutations(two),
  ]
end

inputs.each do |line|
  if line =~ /mask = ([X01]+)/
    mask = $1.split('')
  else
    line =~ /mem\[(\d+)\] = (\d+)/
    id = $1.to_i.to_s(2).split('')
    value = $2.to_i

    addresses = permutations(masked(id, mask)).flatten
    addresses.each do |address|
      #puts "#{address.to_i(2)} [#{address.to_i}] => #{value}"
      mem[address] = value
    end
  end
end

puts mem.values.reduce(&:+)
