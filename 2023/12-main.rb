#! /usr/bin/env ruby

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

queue  = Queue.new
count = 0

input.each do |line, check|
  queue.push([line, check])
end

def valid?(line, check)
  return true if line =~ /\?/

  groups = line.split(/[^#]/).select {|g| g =~ /^#+$/}
  lengths = groups.map(&:length)

  lengths == check.split(',').map(&:to_i)
end

loop_count = 0
loop do
  break if queue.empty?

  puts "[#{loop_count}] Queue: #{queue.size}" if loop_count % 100_000 == 0
  loop_count += 1

  line, check = queue.pop

  if line =~ /\?/
    new_line = line.sub(/\?/, '.')
    queue.push([new_line, check]) if valid?(new_line, check)

    new_line = line.sub(/\?/, '#')
    queue.push([new_line, check]) if valid?(new_line, check)
  else
    # finished line
    count += 1
  end
end

puts count
