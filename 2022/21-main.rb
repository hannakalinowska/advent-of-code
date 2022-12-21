#! /usr/bin/env ruby

$input = File.read('21-input.txt')
#$input = <<-EOF
#root: pppw + sjmn
#dbpl: 5
#cczh: sllz + lgvd
#zczc: 2
#ptdq: humn - dvpt
#dvpt: 3
#lfqf: 4
#humn: 5
#ljgn: 2
#sjmn: drzm * dbpl
#sllz: 4
#pppw: cczh / lfqf
#lgvd: ljgn * ptdq
#drzm: hmdt - zczc
#hmdt: 32
#EOF

$input = $input.split("\n")
$known = {}
one_more_loop = true

def solve(key)
  line = $input.find {|line| line.start_with?(key)}
  line =~ /\w+: (.+)$/
  left, operator, right = $1.split(/ (\+|-|\*|\/) /)
  total = $known[key]
  value = nil

  if left =~ /^\w{4}$/
    key = left
    value = right.to_i
  else
    key = right
    value = left.to_i
  end

  case operator
  when '+'
    $known[key] = total - value
  when '*'
    $known[key] = total / value
  when '-'
    if number?(right)
      # 7 = x - 3
      $known[key] = total + value
    else
      # 7 = 3 - x
      $known[key] = value - total
    end
  when '/'
    if number?(right)
      # 7 = x / 3
      $known[key] = total * value
    else
      # 7 = 3 / x
      $known[key] = value / total
    end
  end

  if key == 'humn'
    return $known[key]
  else
    return solve(key)
  end
end

def number?(string)
  if string =~ /^-?\d+$/
    true
  else
    false
  end
end

# Step 1: simplify the input as much as possible
loop do
  old_input = $input.dup
  one_more_loop = false

  $input.each do |line|
    if line.start_with?('humn')
       $input.delete(line)
       next
    end
    line.gsub!('+', '==') if line.start_with?('root')

    if line =~ /(\w+): (-?\d+)$/
      $known[$1] = $2.to_i
      $input.delete(line)
    else
      line.gsub!(/\w{4}/) do |s|
        $known[s] || s
      end
      begin
        line =~ /\w{4}: (.+)$/
        result = eval($1)
        sub = line.gsub!($1, result.to_s)
        # We replaced something but old_input will still be the same as input.
        # I suspect it's because of my favourite friend, .dup not working as expected.
        # Whatever, let's just cheat and not check the break conditions this time around.
        # What's one extra loop between friends.
        one_more_loop = !sub.nil?
      rescue NameError => e
        # It's fine, it just means that we haven't resolved all the variables in this line yet
      end
    end
  end

  if !one_more_loop
    break if $known['root'] || $input.empty? || old_input == $input
  end
end

# Step 2: now we know what number we're looking for - find and record that number
root = $input.find {|line| line.start_with?('root')}
root =~ /root: (.+) == (.+)$/
left = $1
right = $2
key = nil
value = nil

if left =~ /^\w{4}$/
  key = left
  value = right.to_i
else
  key = right
  value = left.to_i
end
$known[key] = value

# Step 3: With that extra bit of information, solve the rest of the equations
puts solve(key)
