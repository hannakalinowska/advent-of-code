#! /usr/bin/env ruby

input = File.read('09-input.txt')
#input = <<EOF
#0 3 6 9 12 15
#1 3 6 10 15 21
#10 13 16 21 30 45
#EOF
input = input.split("\n")

def diff(row)
  diff_row = []
  row[0 .. -2].each_with_index do |number, i|
    diff_row[i] = row[i+1] - row[i]
  end
  diff_row
end

extrapolated = []
input.each do |line|
  rows = []
  rows[0] = line.split(' ').map(&:to_i)
  i = 0
  loop do
    break if rows[i].uniq == [0]
    rows[i+1] = diff(rows[i])
    i += 1
  end
  # predict next value
  rows.reverse[0 .. -2].each_with_index do |numbers, i|
    rows[rows.length-i-2] << rows[rows.length-i-2].last + rows[rows.length-i-1].last

    if rows.length-i-2 == 0
      extrapolated << rows[0].last
      puts extrapolated.inspect
    end
  end
end

puts extrapolated.sum
