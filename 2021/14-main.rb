#! /usr/bin/env ruby

inputs = File.read('14-input.txt').split("\n")
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
#inputs = inputs.split("\n")

polymer = inputs.shift
inputs.shift

rules = {}
inputs.each do |line|
  key, value = line.split(' -> ')
  rules[key] = value
end

10.times do |i|
  new_polymer = ""
  0.upto(polymer.length - 2) do |start|
    pair = polymer.slice(start, 2)
    new_polymer += "#{pair[0]}#{rules[pair]}"
  end
  new_polymer += polymer[-1]
  polymer = new_polymer
end

counts = polymer.split('').reduce({}) {|acc, l|
  acc[l] ||= 0
  acc[l] += 1
  acc
}.sort {|a, b| a[1] <=> b[1] }

puts counts.last[1] - counts.first[1]
