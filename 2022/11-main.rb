#! /usr/bin/env ruby

require_relative '11/monkey'

input = File.read('11-input.txt')
#input = <<-EOF
#Monkey 0:
#  Starting items: 79, 98
#  Operation: new = old * 19
#  Test: divisible by 23
#    If true: throw to monkey 2
#    If false: throw to monkey 3

#Monkey 1:
#  Starting items: 54, 65, 75, 74
#  Operation: new = old + 6
#  Test: divisible by 19
#    If true: throw to monkey 2
#    If false: throw to monkey 0

#Monkey 2:
#  Starting items: 79, 60, 97
#  Operation: new = old * old
#  Test: divisible by 13
#    If true: throw to monkey 1
#    If false: throw to monkey 3

#Monkey 3:
#  Starting items: 74
#  Operation: new = old + 3
#  Test: divisible by 17
#    If true: throw to monkey 0
#    If false: throw to monkey 1
#EOF
input = input.split("\n\n")

monkeys = input.reduce([]) {|acc, input| acc << Monkey.parse(input); acc}
modulo = monkeys.map {|m| m.test_number}.reduce(:*)
rounds = 10_000

rounds.times do |i|
  puts "Round #{i}" if i % 1000 == 0
  monkeys.each do |monkey|
    loop do
      item = monkey.items.shift
      if item
        item = monkey.operation(item)

        new_item, i = monkey.test(item, modulo)
        monkeys[i].items << new_item
      end

      break if monkey.items.empty?
    end
  end
end

puts monkeys.map {|m| m.count}.max(2).reduce(:*)
