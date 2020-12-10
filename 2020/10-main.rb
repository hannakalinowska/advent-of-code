#! /usr/bin/env ruby

inputs = File.read('10-input.txt').split.map(&:to_i)

inputs << 0
inputs << (inputs.max + 3)

inputs.sort!

#inputs = [0, 1, 2, 3, 4, 5]

tree = {}
$temp_tree = {}

inputs.each_with_index do |input, i|
  tree[input] = []
  tree[input] << inputs[i+1] if inputs[i+1] && inputs[i] + 3 >= inputs[i+1]
  tree[input] << inputs[i+2] if inputs[i+2] && inputs[i] + 3 >= inputs[i+2]
  tree[input] << inputs[i+3] if inputs[i+3] && inputs[i] + 3 >= inputs[i+3]
end

def traverse(i, tree)
  #puts i.inspect
  if tree[i].empty?
    return 1
  else
    tree[i].map { |n|
      if $temp_tree[n]
        count = $temp_tree[n]
      else
        count = traverse(n, tree)
        $temp_tree[n] = count
      end
      count
    }.reduce(&:+)
  end
end

result = traverse(0, tree)
puts result
