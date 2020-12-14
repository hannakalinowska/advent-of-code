#! /usr/bin/env ruby

inputs = File.read('11-input.txt').split.map { |l| l.split('') }
#inputs = inputs[0..8].map{|l| l[0..12]}

def pp(seating)
  puts seating.map {|l| l.join(' ')}.join("\n")
end

def pprs(i, j, seating, relevant_seats)
  new_seating = []
  lookup = relevant_seats[key(i,j)] || []

  seating.each_with_index do |line, row|
    new_seating[row] = []

    line.each_with_index do |_, column|
      if lookup.include?([row,column])
        new_seating[row][column] = "\e[0;31m#{seating[row][column]}\e[0m"
      elsif row == i && column == j
        new_seating[row][column] = "\e[0;33m#{seating[row][column]}\e[0m"
      else
        new_seating[row][column] = seating[row][column]
      end
    end
  end
  pp new_seating
end

# we're going to try to use pointers in this whole thing.
def top(i, j, seating)
  loop do
    j -= 1

    return nil if j < 0

    if seating[i][j] != '.'
      return [i, j]
    end
  end
end

def topright(i, j, seating)
  loop do
    i += 1
    j -= 1

    return nil if j < 0
    return nil if i >= seating.length

    if seating[i][j] != '.'
      return [i, j]
    end
  end
end

def right(i, j, seating)
  loop do
    i += 1

    return nil if i >= seating.length

    begin
    if seating[i][j] != '.'
      return [i, j]
    end
    rescue
      require 'pry'; binding.pry
    end
  end
end

def bottomright(i, j, seating)
  loop do
    i += 1
    j += 1

    return nil if j >= seating.first.length
    return nil if i >= seating.length

    if seating[i][j] != '.'
      return [i, j]
    end
  end
end

def bottom(i, j, seating)
  loop do
    j += 1

    return nil if j >= seating.first.length

    if seating[i][j] != '.'
      return [i, j]
    end
  end
end

def bottomleft(i, j, seating)
  loop do
    i -= 1
    j += 1

    return nil if j >= seating.first.length
    return nil if i < 0

    if seating[i][j] != '.'
      return [i, j]
    end
  end
end

def left(i, j, seating)
  loop do
    i -= 1

    return nil if i < 0

    if seating[i][j] != '.'
      return [i, j]
    end
  end
end

def topleft(i, j, seating)
  loop do
    i -= 1
    j -= 1

    return nil if j < 0
    return nil if i < 0

    if seating[i][j] != '.'
      return [i, j]
    end
  end
end

def count_occupied(seating, relevant_seats)
  relevant_seats
    .compact
    .map { |i, j| seating[i][j] }
    .map { |seat| seat == '#' ? 1 : 0 }
    .reduce(&:+)
end

def step(seating, relevant_seats)
  new_seating = []

  seating.each_with_index do |line, i|
    new_seating[i] = []

    line.each_with_index do |seat, j|
      if seat == '.'
        new_seating[i][j] = seat
      else
        occupied_seats = count_occupied(seating, relevant_seats[key(i, j)])

        case
        when seat == 'L' && occupied_seats == 0
          new_seating[i][j] = '#'
        when seat == '#' && occupied_seats >= 5
          new_seating[i][j] = 'L'
        else
          new_seating[i][j] = seat
        end
      end
    end
  end

  new_seating
end

def key(i, j)
  "#{i}:#{j}"
end

old = inputs
iterations = 0
relevant_seats = {}

inputs.each_with_index do |line, row|
  line.each_with_index do |_, column|
    next if inputs[row][column] == '.'

    relevant_seats[key(row, column)] = [
      top(row, column, inputs),
      topright(row, column, inputs),
      right(row, column, inputs),
      bottomright(row, column, inputs),
      bottom(row, column, inputs),
      bottomleft(row, column, inputs),
      left(row, column, inputs),
      topleft(row, column, inputs),
    ]
  end
end

loop do
  puts iterations if iterations % 100 == 0
  new = step(old, relevant_seats)
  count = 0
  if old == new
    new.each do |l|
      l.each do |s|
        count += 1 if s == '#'
      end
    end
    puts count
    break
  end
  old = new
  iterations += 1
end

