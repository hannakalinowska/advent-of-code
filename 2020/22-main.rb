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

players = inputs.map {|i| i.split("\n")[1 .. -1].map(&:to_i) }
round = 1

$next_game_id = 1
$debug = false

def recursing?(cards, players)
  players.first.length >= cards.first && players.last.length >= cards.last
end

def serialize(players)
  players.map{|p| p.join(',')}.join('::')
end

def game(players, game = 1)
  round = 0
  previous = []
  loop do
    cards = []
    round += 1

    if $debug
      puts "-- Round #{round} (Game #{game}) --"
      puts "Player 1's deck: #{players.first.inspect}"
      puts "Player 2's deck: #{players.last.inspect}"
    end

    if previous.include?(serialize(players))
      # player 1 wins
      result = [players.first, []]

      return result
    else
      previous << serialize(players)

      cards = players.map(&:shift)

      if $debug
        puts "Player 1 plays: #{cards.first}"
        puts "Player 2 plays: #{cards.last}"
      end

      if recursing?(cards, players)
        puts "Playing a sub-game to determine the winner...\n" if $debug
        result = game(
          [
            players.first[0 .. cards.first - 1],
            players.last[0 .. cards.last - 1],
          ],
          $next_game_id += 1
        )
        winner_id = result.index {|r| r.any?}
        winner = players[winner_id]
        if winner_id == 1
          cards.reverse!
        end
      else
        # regular game
        if cards.first > cards.last
          winner = players.first
          puts "Player 1 wins round #{round} of game #{game}!" if $debug
        else
          winner = players.last
          puts "Player 2 wins round #{round} of game #{game}!" if $debug
        end
        cards = cards.sort.reverse
      end
    end

    winner << cards
    winner.flatten!

    return players if players.any?(&:empty?)

    puts if $debug
  end
end

winner = game(players, $next_game_id)

winning_player = players.find {|p| !p.empty?}
puts winning_player.reverse.map.with_index {|s, i| s * (i+1)}.sum
