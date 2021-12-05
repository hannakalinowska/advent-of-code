class Board
  attr_accessor :board

  def self.parse(vents)
    board = []
    vents.each do |vent|
      start, finish = vent.split(' -> ')
      x1, y1 = start.split(',').map(&:to_i)
      x2,y2 = finish.split(',').map(&:to_i)

      case
      when x1 == x2 || y1 == y2
        ([x1, x2].min .. [x1, x2].max).each do |i|
          board[i] ||= []
          ([y1, y2].min .. [y1, y2].max).each do |j|
            board[i][j] ||= 0
            board[i][j] += 1
          end
        end
      when x1 < x2 && y1 < y2
        parse_diagonal_se([x1, x2], [y1, y2], board)
      when x1 > x2 && y1 > y2
        parse_diagonal_se([x2, x1], [y2, y1], board)
      when x1 < x2 && y1 > y2
        parse_diagonal_ne([x1, x2], [y1, y2], board)
      when x1 > x2 && y1 < y2
        parse_diagonal_ne([x2, x1], [y2, y1], board)
      end
    end

    new(board)
  end

  def self.parse_diagonal_se(x, y, board)
    i = x[0]
    j = y[0]
    loop do
      board[i] ||= []
      board[i][j] ||= 0
      board[i][j] += 1

      break if i == x[1] || j == y[1]
      i += 1
      j += 1
    end
  end

  def self.parse_diagonal_ne(x, y, board)
    i = x[0]
    j = y[0]
    loop do
      board[i] ||= []
      board[i][j] ||= 0
      board[i][j] += 1

      break if i == x[1] || j == y[1]
      i += 1
      j -= 1
    end
  end

  def initialize(board)
    @board = board
  end

  def overlapping_count
    @board.flatten.count {|p| p.to_i > 1}
  end
end
