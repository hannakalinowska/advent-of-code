#! /usr/bin/env ruby

inputs = File.read('22-input.txt').split("\n\n")
#inputs = [
#'Player 1:
#9
#2
#6
#3
#1',
#'Player 2:
#5
#8
#4
#7
#10'
#]

player_1 = inputs.first.split("\n")[1 .. -1].map(&:to_i)
player_2 = inputs.last.split("\n")[1 .. -1].map(&:to_i)
round = 1

loop do
  card_1 = player_1.shift
  card_2 = player_2.shift

  if card_1 > card_2
    player_1 << card_1
    player_1 << card_2
  else
    player_2 << card_2
    player_2 << card_1
  end

  break if player_1.empty? || player_2.empty?
  round += 1
end

winning_player = [player_1, player_2].find {|p| !p.empty?}
puts winning_player.reverse.map.with_index {|s, i| s * (i+1)}.sum
