#! /usr/bin/env ruby

input = File.read('13-input.txt')
#input = <<-EOF
#[1,1,3,1,1]
#[1,1,5,1,1]

#[[1],[2,3,4]]
#[[1],4]

#[9]
#[[8,7,6]]

#[[4,4],4,4]
#[[4,4],4,4,4]

#[7,7,7,7]
#[7,7,7]

#[]
#[3]

#[[[]]]
#[[]]

#[1,[2,[3,[4,[5,6,7]]]],8,9]
#[1,[2,[3,[4,[5,6,0]]]],8,9]
#EOF
input = input.split("\n\n")
  .map {|pair| pair.split("\n")}
  .flatten
  .map {|l| eval(l)}

input << [[2]]
input << [[6]]

def compare_arrays(line1, line2)
  max_length = [line1.length, line2.length].max
  (0 .. max_length - 1).each do |i|
    return :correct if line1[i].nil?
    return :incorrect if line2[i].nil?

    result = compare(line1[i], line2[i])
    return result if result != :continue
  end
  :continue
end

def compare_numbers(line1, line2)
  case
  when line1 < line2
    :correct
  when line1 > line2
    :incorrect
  else
    :continue
  end
end

def compare_mixed(line1, line2)
  if line1.is_a?(Integer)
    return compare_arrays([line1], line2)
  else
    return compare_arrays(line1, [line2])
  end
end

def compare(line1, line2)
  result = nil
  case
  when line1.is_a?(Array) && line2.is_a?(Array)
    result = compare_arrays(line1, line2)
  when line1.is_a?(Integer) && line2.is_a?(Integer)
    result = compare_numbers(line1, line2)
  else
    result = compare_mixed(line1, line2)
  end
  result
end

values = {
  :correct => -1,
  :incorrect => 1,
  :continue => 0,
}

sorted = input.sort do |a, b|
  values.fetch(compare(a, b))
end

x = sorted.index([[2]]) + 1
y = sorted.index([[6]]) + 1
puts x * y
