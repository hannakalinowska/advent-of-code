#! /usr/bin/env ruby

inputs = File.read('16-input.txt')
#inputs = <<-EOF
#class: 1-3 or 5-7
#row: 6-11 or 33-44
#seat: 13-40 or 45-50

#your ticket:
#7,1,14

#nearby tickets:
#7,3,47
#40,4,50
#55,2,20
#38,6,12
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


def valid?(number, rules)
  rules.values.flatten.find { |r|
    r.include?(number)
  }
end


result = nearby_tickets.reduce(0) do |acc, t|
  t.each do |n|
    acc += n unless valid?(n, rules)
  end
  acc
end

puts result
