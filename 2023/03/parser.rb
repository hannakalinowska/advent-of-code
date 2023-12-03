module Parser
  class << self
    def extract_number(i, j, input)
      line = input[i]
      start = j

      loop do
        j -= 1
        break if j < 0

        if line[j] =~ /\d/
          start = j
        else
          break
        end
      end

      number = ''
      loop do
        if line[start] =~ /\d/
          number << line[start]
          start += 1
        else
          break
        end
      end
      number.to_i
    end

    def up(i, j, input)
      numbers = []

      return numbers if i == 0

      if input[i-1][j] =~ /\d/
        numbers << extract_number(i-1, j, input)
      elsif input[i-1][j] == '.'
        if input[i-1][j-1] =~ /\d/
          numbers << extract_number(i-1, j-1, input)
        end
        if input[i-1][j+1] =~ /\d/
          numbers << extract_number(i-1, j+1, input)
        end
      end
      numbers
    end

    def down(i, j, input)
      numbers = []

      return numbers if i == input.length - 1

      if input[i+1][j] =~ /\d/
        numbers << extract_number(i+1, j, input)
      elsif input[i+1][j] == '.'
        if input[i+1][j-1] =~ /\d/
          numbers << extract_number(i+1, j-1, input)
        end
        if input[i+1][j+1] =~ /\d/
          numbers << extract_number(i+1, j+1, input)
        end
      end
      numbers
    end

    def left(i, j, input)
      numbers = []

      return numbers if j == 0
      if input[i][j-1] =~ /\d/
        numbers << extract_number(i, j-1, input)
      end
      numbers
    end

    def right(i, j, input)
      numbers = []

      return numbers if j == input[i].length - 1
      if input[i][j+1] =~ /\d/
        numbers << extract_number(i, j+1, input)
      end
      numbers
    end
  end
end
