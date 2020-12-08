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

def run(rules, last_changed_line)
  index = 0
  acc = 0
  visited = []
  changed_line = nil

  loop do
    puts "-------------"
    puts changed_line.inspect
    return acc if index >= rules.length

    line = rules[index]
    #puts "[#{index}] #{line}"

    if visited.include?(index)
      require 'pry'; binding.pry if changed_line.nil?
      return {result: 'loop', last_changed_line: (changed_line || last_changed_line + 1)}
    end

    begin
    if changed_line.nil? && index > last_changed_line && line =~ /^(nop|jmp)/
      changed_line = index
      require 'pry'; binding.pry if changed_line.nil?
      line.gsub!("nop", "jmp") || line.gsub!("jmp", "nop")
      #puts "CHANGED [#{index}] #{line}"
    end
    rescue
      require 'pry'; binding.pry
    end

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
  end
end

changed_line = -1
loop do
  result = run(inputs.dup.map(&:dup), changed_line)
  if result.is_a?(Hash)
    changed_line = result[:last_changed_line]
    require 'pry'; binding.pry if changed_line.nil?
  else
    puts result
    break
  end
end
