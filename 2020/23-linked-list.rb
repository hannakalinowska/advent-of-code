#! /usr/bin/env ruby

input = '364289715'.split('').map(&:to_i)
#input = '389125467'.split('').map(&:to_i)

$debug = false

Cup = Struct.new(:value, :next)
cups = []
previous_cup = nil

input = input + ((input.max + 1) .. 1_000_000).to_a

#(input + ((input.max + 1) .. 1_000_000).to_a).each do |i|
(input).each do |i|
  cup = Cup.new(i)
  cups[i] = cup
  previous_cup.next = cup if previous_cup
  previous_cup = cup
end
cups[input.last].next = cups[input.first]

def pp(cups, start_index = 3)
  cup = cups[start_index]
  values = []
  loop do
    values << cup.value
    cup = cup.next
    break if cup.value == cups[start_index].value
  end

  puts values.join(', ')
end

current_cup = cups[input.first]

10_000_000.times do |i|
  picked_up_cup = current_cup.next
  picked_up_values = [
    picked_up_cup.value,
    picked_up_cup.next.value,
    picked_up_cup.next.next.value
  ]
  joining = picked_up_cup.next.next.next

  current_cup.next = joining
  insert_after = nil
  target_value = current_cup.value - 1
  loop do
    if target_value < 1
      target_value = input.max
    end
    if picked_up_values.include?(target_value)
      target_value -= 1
    else
      insert_after = cups[target_value]
      break
    end
  end
  insert_before = insert_after.next
  insert_after.next = picked_up_cup
  picked_up_cup.next.next.next = insert_before

  pp cups if $debug
  current_cup = current_cup.next
end

puts cups[1].next.value * cups[1].next.next.value
