#! /usr/bin/env ruby

input = File.read('13-input.txt')
#input = <<EOF
#O....#....
#O.OO#....#
#.....##...
#OO.#O....O
#.O.....O#.
#O.#..O.#.#
#..O..#O..O
#.......O..
##....###..
##OO..#....
#EOF
input = input.split("\n").map {|l| l.split('')}

rows = input.length - 1
columns = input.first.length - 1

def round?(field)
  field == 'O'
end

def can_roll?(row, column, input)
  return false if row == 0

  input[row-1][column] == '.'
end

def roll(row, column, input)
  input[row-1][column] = 'O'
  input[row][column] = '.'
end

(0 .. columns).each do |column|
  row = 0
  loop do
    if round?(input[row][column]) && can_roll?(row, column, input)
      roll(row, column, input)
      row -= 1
    else
      break if row == rows
      row += 1
    end
  end
end

total = 0
input.each_with_index do |line, row|
  total += line.count('O') * (rows - row + 1)
end

puts total
