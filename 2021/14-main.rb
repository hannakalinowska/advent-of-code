#! /usr/bin/env ruby

inputs = File.read('14-input.txt')
#inputs = <<-EOF
#NNCB

#CH -> B
#HH -> N
#CB -> H
#NH -> C
#HB -> C
#HC -> B
#HN -> C
#NN -> C
#BH -> H
#NC -> B
#NB -> B
#BN -> B
#BB -> N
#BC -> B
#CC -> N
#CN -> C
#EOF
inputs = inputs.split("\n")

polymer = inputs.shift
inputs.shift
#counts = {}
current = {}
expanded = {}

# build up rules table
rules = {}
inputs.each do |line|
  key, value = line.split(' -> ')
  rules[key] = value
end

def polymer_to_pair_counts(polymer)
  current = {}
  0.upto(polymer.length - 2) do |start|
    pair = polymer.slice(start, 2)
    current[pair] ||= 0
    current[pair] += 1
  end
  current
end

def pair_count_to_letter_count(pair_count)
  letter_counts = {}
  pair_count.each do |pair, count|
    letter_counts[pair[0]] ||= 0
    letter_counts[pair[0]] += count

    letter_counts[pair[1]] ||= 0
    letter_counts[pair[1]] += count
  end
  letter_counts
end

# turn the first polymer into pair counts
current = polymer_to_pair_counts(polymer)

i = 0
40.times do
  # expand pairs
  current.each do |pair, count|
    new_pair_1 = pair[0] + rules[pair]
    new_pair_2 = rules[pair] + pair[1]

    expanded[new_pair_1] ||= 0
    expanded[new_pair_1] += count
    expanded[new_pair_2] ||= 0
    expanded[new_pair_2] += count
  end

  # prepare for next step
  current = expanded
  expanded = {}
end

letter_counts = pair_count_to_letter_count(current)
letter_counts = letter_counts.map do |letter, count|
  occurrences = [polymer[0], polymer[-1]].count(letter)
  [letter, (count+occurrences)/2]
end
letter_counts = letter_counts.to_h

puts letter_counts.values.max - letter_counts.values.min
