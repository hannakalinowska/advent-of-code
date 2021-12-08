#! /usr/bin/env ruby

inputs = File.read('08-input.txt').split(/\n/)
#inputs = <<-EOF
#be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
#edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
#fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
#fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
#aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
#fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
#dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
#bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
#egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
#gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
#EOF
#inputs = inputs.split(/\n/)

sum = 0
inputs.each do |i|
  _, out = i.split(' | ')
  out = out.split.map {|o| o.split('').sort}
  unique = i.split(/(\w+)/).select {|i| i =~ /\w+/}.map {|i| i.split('').sort}

  result = {
    1 => unique.find {|o| o.length == 2},
    4 => unique.find {|o| o.length == 4},
    7 => unique.find {|o| o.length == 3},
    8 => unique.find {|o| o.length == 7},
  }
  unique.delete(result[1])
  unique.delete(result[4])
  unique.delete(result[7])
  unique.delete(result[8])

  result[3] = unique.find {|o| o.length == 5 && (o & result[1]).length == 2}
  unique.delete(result[3])
  result[9] = unique.find {|o| o.length == 6 && (o & result[4]).length == 4}
  unique.delete(result[9])
  result[0] = unique.find {|o| o.length == 6 && (o & result[7]).length == 3}
  unique.delete(result[0])
  result[6] = unique.find {|o| o.length == 6 && !result.values.include?(o)}
  unique.delete(result[6])
  result[5] = unique.find {|o| o.length == 5 && (o & result[6]).length == 5}
  unique.delete(result[5])
  result[2] = unique.find {|o| o.length == 5 && !result.values.include?(o)}
  unique.delete(result[2])

  number = []
  out.each do |o|
    number << result.key(o)
  end
  sum += number.join.to_i
end

puts sum
