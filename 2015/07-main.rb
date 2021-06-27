#! /usr/bin/env ruby

input = File.read('07-input.txt').split("\n")
#input = <<EOF
#123 -> x
#456 -> y
#x AND y -> d
#x OR y -> e
#x LSHIFT 2 -> f
#y RSHIFT 2 -> g
#NOT x -> h
#NOT y -> i
#EOF
#input = input.split("\n")

input = input.map {|line|
  line =~ /^(.+) -> (.+)$/
  assignment = $2
  instruction = $1
    .sub('AND', '&')
    .sub('OR', '|')
    .sub('NOT', '~')
    .sub('LSHIFT', '<<')
    .sub('RSHIFT', '>>')
    .gsub(/([a-z]+)/, 'wires.fetch("\1")')

  "wires['#{assignment}'] = #{instruction}"
}

wires = {}
while(input.any?) do
  line = input.shift
  begin
    eval(line)
  rescue => e
    input.push(line)
  end
end

puts wires['a']
