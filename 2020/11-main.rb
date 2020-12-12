#! /usr/bin/env ruby

inputs = File.read('11-input.txt').split.map { |l| l.split('') }
#inputs = inputs[0..5].map{|l| l[0..5]}

def count_occupied(i, j, seating)
  count = 0
  (i-1 .. i+1).each do |x|
    next if seating[x].nil?
    (j-1 .. j+1).each do |y|
      next if x < 0 || y < 0

      count += 1 if seating[x][y] == '#'
    end
  end
  count -= 1 if seating[i][j] == '#'
  count
end

def step(seating)
  new_seating = []

  seating.each_with_index do |line, i|
    new_seating[i] = []

    line.each_with_index do |seat, j|
      occupied_seats = count_occupied(i, j, seating)

      case
      when seat == 'L' && occupied_seats == 0
        new_seating[i][j] = '#'
      when seat == '#' && occupied_seats >= 4
        new_seating[i][j] = 'L'
      else
        new_seating[i][j] = seat
      end
    end
  end

  new_seating
end


old = inputs
iterations = 0

loop do
  puts iterations if iterations % 100 == 0
  new = step(old)
  require 'pry'; binding.pry if old == new
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

