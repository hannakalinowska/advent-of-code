#! /usr/bin/env ruby

inputs = File.read('11-input.txt').split.map { |l| l.split('') }
inputs = inputs[0..5].map{|l| l[0..5]}

# we're going to try to use pointers in this whole thing.
def top(i, j, seating)
  j.upto(0) {
    if seating[i][j] != '.'
      return seating[i][j]
    end
  }
  nil
end

def topright(i, j, seating)
  loop do
    return nil if j < 0
    return nil if i >= seating.first.length

    if seating[i][j] != '.'
      return seating[i][j]
    end

    i += 1
    j -= 1
  end
end

def right(i, j, seating)
  loop do
    return nil if i >= seating.first.length

    if seating[i][j] != '.'
      return seating[i][j]
    end

    i += 1
  end
end

def bottomright(i, j, seating)
  loop do
    return nil if j >= seating.length
    return nil if i >= seating.first.length

    if seating[i][j] != '.'
      return seating[i][j]
    end

    i += 1
    j += 1
  end
end

def bottom(i, j, seating)
  loop do
    return nil if j >= seating.length

    if seating[i][j] != '.'
      return seating[i][j]
    end

    j += 1
  end
end

def bottomleft(i, j, seating)
  loop do
    return nil if j >= seating.length
    return nil if i < 0

    if seating[i][j] != '.'
      return seating[i][j]
    end

    i -= 1
    j += 1
  end
end

def left(i, j, seating)
  loop do
    return nil if i < 0

    if seating[i][j] != '.'
      return seating[i][j]
    end

    i -= 1
  end
end

def topleft(i, j, seating)
  loop do
    return nil if j < 0
    return nil if i < 0

    if seating[i][j] != '.'
      return seating[i][j]
    end

    i -= 1
    j -= 1
  end
end

def count_occupied(i, j, seating)
  [
    top(i, j, seating),
    topright(i, j, seating),
    right(i, j, seating),
    bottomright(i, j, seating),
    bottom(i, j, seating),
    bottomleft(i, j, seating),
    left(i, j, seating),
    topleft(i, j, seating),
  ].map {|seat| seat == '#' ? 1 : 0}.reduce(&:+)
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
      when seat == '#' && occupied_seats >= 5
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
  require 'pry'; binding.pry #if old == new
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

