#! /usr/bin/env ruby

inputs = File.read('11-input.txt').split(/\n/).map {|line| line.split('').map(&:to_i)}
#inputs = <<-EOF
#5483143223
#2745854711
#5264556173
#6141336146
#6357385478
#4167524645
#2176841721
#6882881134
#4846848554
#5283751526
#EOF
#inputs = inputs.split(/\n/).map {|line| line.split('').map(&:to_i)}

def step(inputs)
  inputs.each_with_index do |line, i|
    line.each_with_index do |c, j|
      inputs[i][j] += 1
    end
  end

  while inputs.flatten.any? {|n| n > 9 } do
    inputs.each_with_index do |line, i|
      line.each_with_index do |c, j|
        if c > 9
          inputs[i][j] = 0
          @flashes += 1

          inputs[i+1][j-1] += 1 if j > 0 && inputs[i+1][j-1].to_i > 0 rescue nil
          inputs[i+1][j] += 1 if inputs[i+1][j].to_i > 0 rescue nil
          inputs[i+1][j+1] += 1 if inputs[i+1][j+1].to_i > 0 rescue nil
          inputs[i][j-1] += 1 if j > 0 && inputs[i][j-1].to_i > 0 rescue nil
          inputs[i][j+1] += 1 if inputs[i][j+1].to_i > 0 rescue nil
          inputs[i-1][j-1] += 1 if i > 0 && j > 0 && inputs[i-1][j-1].to_i > 0 rescue nil
          inputs[i-1][j] += 1 if i > 0 && inputs[i-1][j].to_i > 0 rescue nil
          inputs[i-1][j+1] += 1 if i > 0 && inputs[i-1][j+1].to_i > 0 rescue nil
        end
      end
    end
  end
end

@flashes = 0
i = 0
loop do
  i += 1
  step(inputs)
  break if inputs.flatten.uniq == [0]
end

puts i
