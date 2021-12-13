#! /usr/bin/env ruby

inputs = File.read('13-input.txt')
#inputs = <<-EOF
#6,10
#0,14
#9,10
#0,3
#10,4
#4,11
#6,0
#6,12
#4,1
#0,13
#10,12
#3,4
#3,0
#8,4
#1,10
#2,14
#8,10
#9,0

#fold along y=7
#fold along x=5
#EOF

points, folds = inputs.split("\n\n").map {|i| i.split("\n")}
points = points.map {|p| p.split(',').map(&:to_i) }

folds.each do |fold|
  fold =~ /(x|y)=(\d+)$/
  direction = $1
  fold_line = $2.to_i

  new_points = []
  points.each do |x, y|
    if direction == 'x' && x > fold_line
      x = fold_line - (fold_line - x).abs
    end

    if direction == 'y' && y > fold_line
      y = fold_line - (fold_line - y).abs
    end

    new_points << [x, y]
  end
  points = new_points.uniq
end

paper = []
points.each do |x,y|
  paper[y] ||= []
  paper[y][x] = true
end

paper.each do |row|
  row.each do |value|
    value ? print('#') : print('.')
  end
  print "\n"
end
