#! /usr/bin/env ruby

inputs = File.read('05-input.txt').split

def move(direction, range)
  if range.size == 2
    case direction
    when 'F', 'L'
      return range.first
    when 'B', 'R'
      return range.last
    end
  end

  length = range.size / 2
  case direction
  when 'F', 'L'
    return (range.first .. range.first + length - 1)
  when 'B', 'R'
    return (range.first + length .. range.last)
  end
end

def traverse(directions, range)
  directions.reduce(range) do |r, c|
    move(c, r)
  end
end

seat_ids = inputs.map do |line|
  row = traverse(line[0,7].split(''), (0..127))
  column = traverse(line[7,11].split(''), (0 .. 7))

  row * 8 + column
end

previous_id = nil
seat_ids.sort.each do |id|
  if previous_id && previous_id + 1 != id
    puts id - 1
    exit
  end
  previous_id = id
end
