class Board
  attr_accessor :board, :moves_to_win

  def initialize(line)
    @board = line.split("\n").map(&:split)
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
    (0 .. 4).each do |i|
      (0 .. 4).each do |j|
        if @board[i][j] == n
          #puts "Marking as won"
          #puts @board.inspect
          @board[i][j] = nil
        end
      end
    end
  end

  def won?
    (0 .. 4).each do |i|
      return true if @board[i].uniq == [nil]
      return true if @board.transpose[i].uniq == [nil]
    end
    false
  end

  def score
    @board.flatten.compact.map(&:to_i).sum * @last_number
  end
end
