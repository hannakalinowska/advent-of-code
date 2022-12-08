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

def look_left(tree, i, j, input)
  line = j > 0 ? input[i][0 .. j-1].reverse : []
  selected = []
  line.each do |t|
    selected << t
    break if t >= tree
  end
  selected
end

def look_right(tree, i, j, input)
  line = input[i][j+1 .. -1]
  selected = []
  line.each do |t|
    selected << t
    break if t >= tree
  end
  selected
end

def look_up(tree, i, j, input)
  line = i > 0 ? input[0 .. i-1].map {|l| l[j]}.reverse : []
  selected = []
  line.each do |t|
    selected << t
    break if t >= tree
  end
  selected
end

def look_down(tree, i, j, input)
  line = input[i+1 .. -1].map {|l| l[j]}
  selected = []
  line.each do |t|
    selected << t
    break if t >= tree
  end
  selected
end

max_scenic_score = 0
input.each_with_index do |line, i|
  line.each_with_index do |tree, j|
    scenic_score = [
      look_left(tree, i, j, input).length,
      look_right(tree, i, j, input).length,
      look_up(tree, i, j, input).length,
      look_down(tree, i, j, input).length,
    ].reduce(:*)

    if scenic_score > max_scenic_score
      max_scenic_score = scenic_score
    end
  end
end
puts max_scenic_score
