#! /usr/bin/env ruby

require_relative '23/elf'
require_relative '23/board'

input = File.read('23-input.txt')
#input = <<-EOF
#..............
#..............
#.......#......
#.....###.#....
#...#...#.#....
#....#...##....
#...#.###......
#...##.#.##....
#....#..#......
#..............
#..............
#..............
#EOF
input = input.split("\n").map {|line| line.split('')}

def pretty_print(positions)
  min_x = positions.map(&:first).flatten.min
  max_x = positions.map(&:first).flatten.max
  min_y = positions.map(&:last).flatten.min
  max_y = positions.map(&:last).flatten.max

  min_x.upto(max_x) do |x|
    print "%2d " % x
    min_y.upto(max_y) do |y|
      if positions.include?([x,y])
        print '#'
      else
        print '.'
      end
    end
    puts
  end
  puts
end

elves = []
board = Board.new

input.each_with_index do |line, i|
  line.each_with_index do |c, j|
    if c == '#'
      elves << Elf.new(i, j, board: board)
    end
  end
end

board.elves = elves

round = 0
direction_order = %w(N S W E)
t = Time.now
loop do
  puts "======= Round #{round} (#{Time.now - t}) =========="
  t = Time.now
  #pretty_print(elves.map(&:position))

  # Step 1: try
  proposed_moves = {}
  elves.each do |elf|
    proposed_move = elf.proposed_move(elves, direction_order)

    if proposed_move
      proposed_moves[proposed_move] ||= []
      proposed_moves[proposed_move] << elf
    end
  end

  # Step 2: commit
  proposed_moves.each do |key, elves|
    if elves.size == 1
      elves.first.commit
    else
      elves.map(&:cancel)
    end
  end
  board.commit
  round += 1
  direction_order.rotate!

  break if proposed_moves.empty?
end
#puts "======= Round #{round} ============="
#pretty_print(elves.map(&:position))

puts round
