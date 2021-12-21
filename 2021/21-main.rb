#! /usr/bin/env ruby

class Player
  attr_accessor :position, :score

  def initialize(start)
    @position = start - 1
    @score = 0
  end

  def move(forward)
    @position = (@position + forward) % 10
    @score += @position + 1
  end
end

class Die
  attr_accessor :roll_count
  def initialize
    @result = -1
    @roll_count = 0
  end

  def roll
    @roll_count += 1

    @result = (@result + 1) % 100
    @result + 1
  end
end

players = [Player.new(1), Player.new(3)]
die = Die.new

loop do
  move = die.roll + die.roll + die.roll
  players.first.move(move)

  break if players.first.score >= 1000

  move = die.roll + die.roll + die.roll
  players.last.move(move)

  break if players.last.score >= 1000
end

player = players.find {|p| p.score < 1000}
puts player.score * die.roll_count
