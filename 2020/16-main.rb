#! /usr/bin/env ruby

inputs = File.read('16-input.txt')
#inputs = <<-EOF
#class: 0-1 or 4-19
#row: 0-5 or 8-19
#seat: 0-13 or 16-19

#your ticket:
#11,12,13

#nearby tickets:
#3,9,18
#15,1,5
#5,14,9
#EOF

inputs = inputs.split("\n\n")


rules = inputs[0].split("\n").reduce({}) { |acc, r|
  key, values = r.split(': ')

  values = values.split(' or ').map {|v|
    v =~ /^(\d+)-(\d+)$/
    ($1.to_i .. $2.to_i)
  }

  acc[key] = values
  acc
}

your_ticket = inputs[1].split("\n").last.split(',').map(&:to_i)
nearby_tickets = inputs[2].split("\n")[1..-1].map {|t| t.split(",").map(&:to_i)}


def matching_rule?(numbers, rule)
  result = numbers.find {|v| rule.all? {|r| !r.include?(v) } }
  !result
end

def valid?(number, rules)
  result = rules.values.flatten.find { |r|
    r.include?(number)
  }
  !!result
end

valid_tickets = nearby_tickets.select do |t|
  t.map { |n| valid?(n, rules) }.uniq == [true]
end

headers = []

loop do
  (0 .. rules.size - 1).each do |i|
    next if headers[i]

    field = valid_tickets.transpose.at(i)
    rule, _ = rules.select {|k, v| matching_rule?(field, v) && !headers.include?(k)}

    if rule.values.size > 1
      next
    else
      headers[i] = rule.keys.first
    end
  end
  break if headers.compact.size == rules.size
end

result = 1
headers.each.with_index do |header, i|
  if header.start_with?("departure")
    result *= your_ticket[i]
  end
end

puts result
