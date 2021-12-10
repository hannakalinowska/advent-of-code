#! /usr/bin/env ruby

inputs = File.read("10-input.txt").split(/\n/)
#inputs = <<-EOF
#[({(<(())[]>[[{[]{<()<>>
#[(()[<>])]({[<{<<[]>>(
#{([(<{}[<>[]}>{[]{[(<()>
#(((({<>}<{<{<>}{[]{[]{}
#[[<[([]))<([[{}[[()]]]
#[{[{({}]{}}([{[{{{}}([]
#{<[[]]>}<{[{[{[]{()[[[]
#[<(<(<(<{}))><([]([]()
#<{([([[(<>()){}]>(<<{{
#<{([{{}}[<[[[<>{}]]]>[]]
#EOF

#inputs = <<-EOF
#{([(<{}[<>[]}>{[]{[(<()>
#[[<[([]))<([[{}[[()]]]
#EOF
#inputs = inputs.split(/\n/)

@pairs = {
  '(' => ')',
  '[' => ']',
  '{' => '}',
  '<' => '>',
}
@scores = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137,
}

def score(char)
  @scores[char]
end

def valid?(stack, line)
  while line.any? do
    char = line.shift

    case
    when @pairs.keys.include?(char)
      stack.unshift(char)
    when @pairs.values.include?(char)
      if @pairs[stack.first] == char
        stack.shift
      else
        return score(char)
      end
    end
  end
  return stack.empty?
end

scores = inputs.map do |line|
  line = line.split('')

  stack = []
  valid?(stack, line)
end

puts scores.reject {|s| s == false}.sum
