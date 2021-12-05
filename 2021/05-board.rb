class Board
  attr_accessor :board

  def self.parse(vents)
    board = []
    vents.each do |vent|
      start, finish = vent.split(' -> ')
      x1, y1 = start.split(',').map(&:to_i)
      x2,y2 = finish.split(',').map(&:to_i)

      if x1 == x2 || y1 == y2
        ([x1, x2].min .. [x1, x2].max).each do |i|
          board[i] ||= []
          ([y1, y2].min .. [y1, y2].max).each do |j|
            board[i][j] ||= 0
            board[i][j] += 1
          end
        end
      end
    end

    require 'pry'; binding.pry
    new(board)
  end

  def initialize(board)
    @board = board
  end

  def overlapping_count
    @board.flatten.count {|p| p.to_i > 1}
  end
end
