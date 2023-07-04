#! /usr/bin/env ruby

class Player
  attr_accessor :position, :score, :name

  def initialize(start, name = 'Foo')
    @position = start - 1
    @score = 0
    @name = name
  end

  def move(forward)
    @position = (@position + forward) % 10
    @score += @position + 1
    #puts "#{@name} -> #{@position + 1}; score: #{@score}"
  end

  def won?
    @score >= 21
  end
end

class Score
  attr_accessor :player, :count
  def initialize(player)
    @player = player
    @count = 0
  end

  def +(n)
    @count += n
  end
end

class Die
  def self.all_outcomes
    [
      3,
      4, 4, 4,
      5, 5, 5, 5, 5, 5,
      6, 6, 6, 6, 6, 6, 6,
      7, 7, 7, 7, 7, 7,
      8, 8, 8,
      9
    ]
  end
end

WINNING_SCORE = 21
@alice_score = 0
@total_games = 0

def play(alice_position:, alice_score:, bob_position:, bob_score:)
  #puts "Alice: #{alice}, Bob: #{bob}, game: #{game.inspect}"
  case
  when alice_score >= WINNING_SCORE
    @alice_score += 1
    @total_games += 1
    return {
      alice_position: alice_position,
      alice_score: alice_score,
      bob_position: bob_position,
      bob_score: bob_score
    }
  when bob_score >= WINNING_SCORE
    @total_games += 1
    return {
      alice_position: alice_position,
      alice_score: alice_score,
      bob_position: bob_position,
      bob_score: bob_score
    }
  else
    Die.all_outcomes.each do |move|
      play(alice_position: alice_position, alice_score: alice_score, bob_position: bob_position, bob_score: bob_score)
    end
  end
end

play(alice_position: 1, alice_score: 0, bob_position: 3, bob_score: 0)
require 'pry'; binding.pry
puts @total_games

#def play(alice, bob)
#  Die.all_outcomes.each do |move|
#    print "Alice: #{move}. "
#    alice[0] = (alice[0] + move) % 10
#    alice[1] += alice[0] + 1

#    if alice[1] >= 21
#      alice[2] += 1
#      puts "Alice won. #{alice[2]}:#{bob[2]}"
#      return [alice[2], bob[2]]
#    end

#    Die.all_outcomes.each do |move|
#      print "Bob: #{move}. "
#      bob[0] = (bob[0] + move) % 10
#      bob[1] += bob[0] + 1

#      if bob[1] >= 21
#        bob[2] += 1
#        require 'pry'; binding.pry
#        puts "Bob won. #{alice[2]}:#{bob[2]}"
#        return [alice[2], bob[2]]
#      end

#      alice_score, bob_score = play(alice, bob)
#    end
#  end
#  [alice[2], bob[2]]
#end

#alice = [1, 0, 0, 'Alice']
#bob = [3, 0, 0, 'Bob']

#alice_score, bob_score = play(alice, bob)
#puts "--------------------"

#require 'pry'; binding.pry
#puts

##puts "1: #{players.first.position} (#{players.first.score}), 2: #{players.last.position} (#{players.last.score})"
