#! /usr/bin/env ruby

inputs = File.read('07-input.txt').split("\n")

#inputs = [
#  "light red bags contain 1 bright white bag, 2 muted yellow bags.",
#  "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
#  "bright white bags contain 1 shiny gold bag.",
#  "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
#  "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
#  "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
#  "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
#  "faded blue bags contain no other bags.",
#  "dotted black bags contain no other bags.",
#]

BAG = 'shiny gold'

def parse_inside_out(rules)
  rules.reduce({}) do |acc, rule|
    if rule =~ /no other bags/
      acc
    else
      key, *values = rule.split(/contain|, /).map{ |s| s.gsub(/\d|\./, '').gsub(/bags?/, '').strip }
      values.each {|v| acc[v] ||= []; acc[v] << key}
      acc
    end
  end
end

def outermost_colour(colour, rules)
  return colour if rules[colour].nil?

  colours = rules[colour] + rules[colour].map do |c|
    outermost_colour(c, rules)
  end
  colours
end

def parse_outside_in(rules)
  rules.reduce({}) do |acc, rule|
    if rule =~ /^(.+) bags contain no other bags/
      acc[$1] = []
      acc
    else
      key, *values = rule.split(/contain|, /).map{ |s| s.gsub(/\.|bags?/, '').strip }
      acc[key] ||= []
      values.each do |v|
        count, name = v.split(' ', 2)
        acc[key] << {name: name, count: count.to_i}
      end
      acc
    end
  end
end

def count_bags(colour, rules)
  puts colour.inspect
  puts rules[colour].inspect
  return 1 if rules[colour].empty?

  rules[colour].reduce(1) do |acc, rule|
    acc += rule[:count] * count_bags(rule[:name], rules)
    acc
  end
end

#rules = parse_inside_out(inputs)
#result = outermost_colour(BAG, rules).flatten.uniq

rules = parse_outside_in(inputs)
result = count_bags(BAG, rules) - 1
puts result
