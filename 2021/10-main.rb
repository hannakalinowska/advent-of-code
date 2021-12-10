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
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
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
        return false
      end
    end
  end

  stack.reduce(0) {|acc, s|
    acc * 5 + @scores[@pairs[s]]
  }
end

scores = inputs.map do |line|
  line = line.split('')

  stack = []
  valid?(stack, line)
end

scores = scores.reject {|s| s == false}.sort
puts scores[scores.size/2]
