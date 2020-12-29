#! /usr/bin/env ruby

inputs = File.read('08-input.txt').split("\n")
#inputs = [
#  "nop +0",
#  "acc +1",
#  "jmp +4",
#  "acc +3",
#  "jmp -3",
#  "acc -99",
#  "acc +1",
#  "jmp -4",
#  "acc +6",
#].freeze

def tweak(rules, line_number)
  new_rules = []
  rules.each.with_index do |line, i|
    if i == line_number
      if line =~ /^nop (.+)$/
        new_line = line.gsub('nop', 'jmp')
      else
        new_line = line.gsub('jmp', 'nop')
      end
      new_rules << new_line
    else
      new_rules << line
    end
  end
  new_rules
end

def run(rules)
  index = 0
  acc = 0
  visited = []
  loop do
    line = rules[index]
    visited << index
    case line
    when /^nop/
      index += 1
    when /^acc ([+-]\d+)$/
      number = $1.to_i
      acc += number
      index += 1
    when /^jmp ([+-]\d+)$/
      number = $1.to_i
      index += number
    end
    return acc if index >= rules.size
    return false if visited.include?(index)
  end
end

inputs.size.times do |i|
  new_rules = tweak(inputs, i)
  next if new_rules == inputs

  result = run(new_rules)
  if result
    puts result
    break
  end
end
