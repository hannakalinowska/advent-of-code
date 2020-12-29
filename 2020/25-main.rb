#! /usr/bin/env ruby

card_pk, door_pk = File.read('25-input.txt').split("\n").map(&:to_i)

subject_number = 7
value = 1

def calculate(value, subject_number)
  (value * subject_number) % 20201227
end

def find_loop_size(subject_number, public_key)
  value = 1
  100_000_000.times do |i|
    value = calculate(value, subject_number)
    if value == public_key
      return i + 1
    end
  end
end

def find_encryption_key(subject_number, loop_size)
  value = 1
  loop_size.times do |i|
    value = calculate(value, subject_number)
  end
  value
end

#card_loop_size = 397859
#door_loop_size = 16774994

card_loop_size = find_loop_size(7, card_pk)
door_loop_size = find_loop_size(7, door_pk)

encryption_key_1 = find_encryption_key(door_pk, card_loop_size)
encryption_key_2 = find_encryption_key(card_pk, door_loop_size)

puts encryption_key_1
