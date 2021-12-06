class Board
  attr_accessor :board, :moves_to_win

  def initialize(line)
    @board = line.split("\n").map(&:split).flatten
    @moves_to_win = nil
    @last_number = nil
  end

  def play(numbers)
    numbers.each_with_index do |n, i|
      mark(n)
      if won?
        @moves_to_win = i
        @last_number = n.to_i
        return true
      end
    end
    false
  end

  def mark(n)
    @board.map! do |i|
      i == n ? nil : i
    end
  end

  def won?
    @board.include?([nil, nil, nil, nil, nil])

    (0 .. 4).each do |i|
      return true if @board.values_at(i, i+5, i+2*5, i+3*5, i+4*5).uniq == [nil]
    end
    [0, 5, 10, 15, 20].each do |i|
      return true if @board[i .. i+4].uniq == [nil]
    end
    false
  end

  def score
    @board.flatten.compact.map(&:to_i).sum * @last_number
  end
end
