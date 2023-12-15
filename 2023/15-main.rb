#! /usr/bin/env ruby

input = File.read('15-input.txt')
#input = <<EOF
#rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
#EOF
input = input.strip.split(',')

total = 0
input.each do |instruction|
  current_value = 0
  instruction.split('').each do |c|
    current_value += c.ord
    current_value *= 17
    current_value %= 256
  end
  total += current_value
end

puts total
