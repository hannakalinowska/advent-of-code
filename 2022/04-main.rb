#! /usr/bin/env ruby

input = File.read('04-input.txt').split

count = 0
input.each do |line|
  elf1, elf2 = line.split(',')

  elf1 =~ /^(\d+)-(\d+)$/
  elf1_start = $1.to_i
  elf1_end = $2.to_i

  elf2 =~ /^(\d+)-(\d+)$/
  elf2_start = $1.to_i
  elf2_end = $2.to_i

  if (elf1_start .. elf1_end).include?(elf2_start) ||
      (elf1_start .. elf1_end).include?(elf2_end) ||
      (elf2_start .. elf2_end).include?(elf1_start) ||
      (elf2_start .. elf2_end).include?(elf1_end)
    count += 1
  end
end

puts count
