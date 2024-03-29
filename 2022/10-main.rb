#! /usr/bin/env ruby

input = File.read('10-input.txt')
#input = File.read('10-sample-input.txt')
input = input.split("\n")

DURATIONS = {
  'noop' => 1,
  'addx' => 2
}

tick = 1
register = 1
elapsed = 0
instruction = nil
value = nil
signal_strength = 0
column = 0

loop do
  # find the next instruction or continue the previous one
  if DURATIONS[instruction] == elapsed || instruction.nil?
    instruction, value = input.shift.split(' ')
    elapsed = 0
  end

  # draw pixels
  if (register - 1 .. register + 1).include?(column)
    print '#'
  else
    print '.'
  end

  # check signal strength
  if tick % 40 == 20
    signal_strength += tick * register
  end

  # finish cycle
  elapsed += 1
  tick += 1
  column += 1

  # post-cycle actions
  case instruction
  when 'addx'
    if DURATIONS[instruction] == elapsed
      register += value.to_i
    end
  end
  if column == 40
    puts
    column = 0
  end

  break if input.empty?
end
#puts signal_strength
