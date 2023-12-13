#! /usr/bin/env ruby
require_relative '12/springs_checker'

input = File.read('12-input.txt')
#input = <<EOF
#???.### 1,1,3
#.??..??...?##. 1,1,3
#?#?#?#?#?#?#?#? 1,3,1,6
#????.#...#... 4,1,1
#????.######..#####. 1,6,5
#?###???????? 3,2,1
#EOF
input = input.split("\n").map {|l| l.split(' ')}

# unfold input
input = input.map do |line, check|
  [
    ([line]*5).join('?'),
    ([check]*5).join(',')
  ]
end

queue  = Queue.new
count = 0

input.each do |line, check|
  queue.push([line, check])
end

loop_count = 0
loop do
  break if queue.empty?

  puts "[#{loop_count}] Queue: #{queue.size} Count: #{count}" if loop_count % 100_000 == 0
  loop_count += 1

  line, check = queue.pop

  if line =~ /\?/
    new_line = line.sub(/\?/, '.')
    if SpringsChecker.valid?(new_line, check)
      queue.push([new_line, check])
    #else
    #  puts new_line
    #  require 'pry-byebug'; binding.pry unless new_line =~ /^\.*#\.+#\.+#\.+/
    end

    new_line = line.sub(/\?/, '#')
    if SpringsChecker.valid?(new_line, check)
      queue.push([new_line, check])
    #else
    #  puts new_line
    #  require 'pry-byebug'; binding.pry unless new_line =~ /^\.*#\.+#\.+#\.+/
    end
  else
    # finished line
    count += 1
  end
end

puts "loop count: #{loop_count}"
puts count
