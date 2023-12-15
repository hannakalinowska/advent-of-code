#! /usr/bin/env ruby

input = File.read('15-input.txt')
#input = <<EOF
#rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
#EOF
input = input.strip.split(',')

def hash(string)
  current_value = 0
  string.split('').each do |c|
    current_value += c.ord
    current_value *= 17
    current_value %= 256
  end
  current_value
end

boxes = []
input.each do |instruction|
  instruction =~ /^(\w+)([=-])(\d+)?/

  label = $1
  operation = $2
  focal_length = $3.to_i
  box = hash(label)

  boxes[box] ||= {}
  if operation == '='
    boxes[box][label] = focal_length
  else
    boxes[box].delete(label)
  end
end

total = 0
boxes.each_with_index do |box, i|
  (box || {}).each_with_index do |lens, j|
    total += (1+i) * (j+1) * lens.last
  end
end
puts total
