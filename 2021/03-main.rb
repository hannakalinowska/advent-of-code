#! /usr/bin/env ruby

inputs = File.read('03-input.txt').split(/\n/).map {|line| line.split("") }

#inputs = "00100
#11110
#10110
#10111
#10101
#01111
#00111
#11100
#10000
#11001
#00010
#01010".split(/\n/).map {|l| l.split ''}

generator = inputs.clone
scrubber = inputs.clone

i = 0
loop do
  line = generator.transpose[i]
  count = line.reduce({'0' => 0, '1' => 0}) {|acc, l| acc[l] += 1; acc}

  max = '1' if count['0'] == count['1']
  max ||= count.max {|a,b| a.last <=> b.last }.first

  generator = generator.select {|l| l[i] == max }
  break if generator.size <= 1
  i += 1
end

i = 0
loop do
  line = scrubber.transpose[i]
  count = line.reduce({'0' => 0, '1' => 0}) {|acc, l| acc[l] += 1; acc}

  min = '0' if count['0'] == count['1']
  min ||= count.min {|a,b| a.last <=> b.last }.first

  scrubber = scrubber.select {|l| l[i] == min }
  break if scrubber.size <= 1
  i += 1
end

puts generator.join.to_i(2) * scrubber.join.to_i(2)
