#! /usr/bin/env ruby

inputs = File.read('input.txt').split.map(&:to_i)

def two_numbers(inputs, sum)
  inputs.each do |number|
    complement = sum - number
    if inputs.include?(complement)
      return number * complement
    end
  end
  false
end

def three_numbers(inputs, sum)
  inputs.each do |number|
    complement = sum - number
    two = two_numbers(inputs, complement)
    if two
      puts number
      return two * number
    end
  end
  false
end

puts three_numbers(inputs, 2020)
