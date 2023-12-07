#! /usr/bin/env ruby

input = File.read('07-input.txt')
#input = <<EOF
#32T3K 765
#T55J5 684
#KK677 28
#KTJJT 220
#QQQJA 483
#EOF
input = input.split("\n")

class Hand
  attr_reader :cards, :bid

  def initialize(cards, bid)
    @cards = cards.split('')
    @bid = bid.to_i
  end

  def rank
    case
    when five_of_a_kind?; 7
    when four_of_a_kind?;  6
    when full_house?;  5
    when three_of_a_kind?; 4
    when two_pair?; 3
    when one_pair?; 2
    when high_card?; 1
    end
  end

  private

  def five_of_a_kind?
    lengths == [5]
  end

  def four_of_a_kind?
    lengths == [1, 4]
  end

  def full_house?
    lengths == [2, 3]
  end

  def three_of_a_kind?
    lengths == [1, 1, 3]
  end

  def two_pair?
    lengths == [1, 2, 2]
  end

  def one_pair?
    lengths == [1, 1, 1, 2]
  end

  def high_card?
    lengths == [1, 1, 1, 1, 1]
  end

  def lengths
    return @lengths if defined?(@lengths)

    lengths = @cards.tally
    if lengths['J'] && lengths['J'] < 5
      jokers = lengths.delete('J')
      max = lengths.max_by {|l| l.last}
      lengths[max.first] += jokers
    end
    @lengths = lengths.values.sort
  end
end

def card_sort(a, b)
  order = %w(A K Q T 9 8 7 6 5 4 3 2 J)
  if order.find_index(a) > order.find_index(b)
    1
  elsif order.find_index(a) < order.find_index(b)
    -1
  else
    0
  end
end

def camel_sort(a, b)
  if a.rank.nil? || b.rank.nil?
    require 'pry'; binding.pry
  end
  case
  when a.rank < b.rank
    1
  when b.rank < a.rank
    -1
  else
    5.times do |i|
      card_compare = card_sort(a.cards[i], b.cards[i])
      if card_compare == 0
      else
        return card_compare
      end
    end
    return 0
  end
end

hands = input.map do |line|
  Hand.new(*line.split(' '))
end

sorted = hands.sort {|a, b| camel_sort(a, b)}

result = []
sorted.reverse.each_with_index do |hand, i|
  result << hand.bid * (i+1)
end
puts result.sum
