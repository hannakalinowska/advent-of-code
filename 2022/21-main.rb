#! /usr/bin/env ruby

input = File.read('21-input.txt')
input = <<-EOF
root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32
EOF

input = input.split("\n")
known = {}
unknown = []

loop do
  input.each do |line|
    if line =~ /(\w+): (-?\d+)$/
      known[$1] = $2.to_i
      input.delete(line)
    else
      line.gsub!(/\w{4}/) do |s|
        known[s] || s
      end
      begin
        line =~ /\w{4}: (.+)$/
        result = eval($1)
        line.gsub!($1, result.to_s)
      rescue NameError => e
        # It's fine, it just means that we haven't resolved all the variables
      end
    end
  end

  break if known['root'] || input.empty?
end
puts known['root']
