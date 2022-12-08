#! /usr/bin/env ruby

input = File.read('08-input.txt')
#input = <<-EOF
#30373
#25512
#65332
#33549
#35390
#EOF
input = input.split("\n").map {|line| line.split('').map(&:to_i)}

def visible_left?(tree, i, j, input)
  line = j > 0 ? input[i][0 .. j-1] : []
  line.all? {|t| t < tree}
end

def visible_right?(tree, i, j, input)
  line = input[i][j+1 .. -1]
  line.all? {|t| t < tree}
end

def visible_top?(tree, i, j, input)
  line = i > 0 ? input[0 .. i-1].map {|l| l[j]} : []
  line.all? {|t| t < tree}
end

def visible_bottom?(tree, i, j, input)
  line = input[i+1 .. -1].map {|l| l[j]}
  line.all? {|t| t < tree}
end

count = 0
input.each_with_index do |line, i|
  line.each_with_index do |tree, j|
    if visible_left?(tree, i, j, input) || visible_right?(tree, i, j, input) ||
      visible_top?(tree, i, j, input) || visible_bottom?(tree, i, j, input)
      count += 1
    end
  end
end
puts count
