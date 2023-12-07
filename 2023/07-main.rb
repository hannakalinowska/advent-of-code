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
    when five_of_a_kind?
      7
    when four_of_a_kind?
      6
    when full_house?
      5
    when three_of_a_kind?
      4
    when two_pair?
      3
    when one_pair?
      2
    when high_card?
      1
    end
  end

  private

  def five_of_a_kind?
    @cards.uniq.length == 1
  end

  def four_of_a_kind?
    @cards.uniq.length == 2 && lengths == [1, 4]
  end

  def full_house?
    @cards.uniq.length == 2 && lengths == [2, 3]
  end

  def three_of_a_kind?
    @cards.uniq.length == 3 && lengths == [1, 1, 3]
  end

  def two_pair?
    @cards.uniq.length == 3 && lengths == [1, 2, 2]
  end

  def one_pair?
    @cards.uniq.length == 4
  end

  def high_card?
    @cards.uniq.length == 5
  end

  def lengths
    @cards.tally.values.sort
  end
end

def card_sort(a, b)
  order = %w(A K Q J T 9 8 7 6 5 4 3 2)
  if order.find_index(a) > order.find_index(b)
    1
  elsif order.find_index(a) < order.find_index(b)
    -1
  else
    0
  end
end

def camel_sort(a, b)
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
