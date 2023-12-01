#! /usr/bin/env ruby

input = File.read('01-input.txt')
#input = <<EOF
#two1nine
#eightwothree
#abcone2threexyz
#xtwone3four
#4nineeightseven2
#zoneight234
#7pqrstsixteen
#EOF
input = input.split("\n")

spellings = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9',
}

calibration = input.map do |i|
  digits = i.gsub(/(?=(#{spellings.keys.join("|")}))/) { spellings[$1] }
  digits = digits.gsub(/\D/, '')
  "#{digits[0]}#{digits[-1]}".to_i
end

puts calibration.sum
