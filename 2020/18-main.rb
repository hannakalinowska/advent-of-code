#! /usr/bin/env ruby

inputs = File.read('18-input.txt').split("\n")
#inputs = [
#  '1 + 2 * 3 + 4 * 5 + 6',
#  '1 + (2 * 3) + (4 * (5 + 6))',
#  '((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2',
#]

def calculate(expression)
  eval(expression)
end

def step(expression)
  if expression =~ /^(\d+ [+*] \d+)/
    return expression.sub($1, calculate($1).to_s)
  elsif expression =~ /^\d+$/
    return expression
  elsif expression =~ /(\([^()]+\))/
    with_brackets = $1
    without_brackets = with_brackets.gsub(/[()]/, '')
    loop do
      without_brackets = step(without_brackets)
      break if without_brackets =~ /^\d+$/
    end
    return expression.sub(with_brackets, without_brackets.to_s)
  end
end

result = inputs.map do |line|
  loop do
    line = step(line)
    break if line =~ /^\d+$/
  end
  line.to_i
end
puts result.sum
