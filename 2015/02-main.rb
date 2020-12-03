#! /usr/bin/env ruby

inputs = File.read('02-input.txt').split

def wrapping_paper(l, w, h)
  (2 * l * w) + (2 * l * h) + (2 * w * h) + (l * w)
end

def ribbon(l, w, h)
  l + l + w + w + l*w*h
end

length = inputs.map do |dimensions|
  l, w, h = dimensions.split('x').map(&:to_i).sort
  ribbon(l, w, h)
end

puts length.reduce(&:+)
