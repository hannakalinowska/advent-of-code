#! /usr/bin/env ruby

inputs = File.read('19-input.txt').split("\n\n")
#inputs = [
#'0: 4 1 5
#1: 2 3 | 3 2
#2: 4 4 | 5 5
#3: 4 5 | 5 4
#4: "a"
#5: "b"',
#'ababbb
#abbbab
#aaabbb
#aaaabbb'
#]

class Foo
  attr_accessor :rules, :terminators

  def initialize
    @rules = {}
    @terminators = []
  end

  def parse_inputs(inputs)
    inputs.first.split("\n").map do |line|
      key, value = line.split(": ")
      value = value.split(" | ")
      if line =~ /"\w"/
        terminators << key
        rules[key] = [value.flatten.first.gsub('"', '')]
      else
        rules[key] = value
      end
    end
  end

  def expand(rule)
    return rule if rule =~ /^[ab ]+$/

    rule =~ /(\d+)/
    index = $1
    rules[index].map {|r| rule.sub(index, r)}
  end

  def step(rule)
    rule.map {|r| expand(r) }.flatten
  end

  def go!(rule)
    new_rule = []
    loop do
      new_rule = step(rule)
      break if new_rule.all? {|r| r =~ /^[ab ]+$/}
      rule = new_rule
    end
    new_rule
  end
end

foo = Foo.new
foo.parse_inputs(inputs)

#these two rules cover /^[ab]{8}$/
forty_two = foo.go!(foo.rules["42"]).map{|r| r.gsub(' ', '')}
thirty_one = foo.go!(foo.rules["31"]).map {|r| r.gsub(' ', '')}

# 0: 8 11
# 8: 42 | 42 8
# 11: 42 31 | 42 11 31

eight = /(?:#{forty_two.join('|')})+/
eleven = /((?:#{forty_two.join('|')})\g<1>*(?:#{thirty_one.join('|')}))/

words = inputs.last.split("\n")

matching = words.select do |word|
  word =~ /^#{eight}#{eleven}$/
end
puts matching.size
