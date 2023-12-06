#! /usr/bin/env ruby

input = File.read('05-input.txt')
#input = <<EOF
#seeds: 79 14 55 13

#seed-to-soil map:
#50 98 2
#52 50 48

#soil-to-fertilizer map:
#0 15 37
#37 52 2
#39 0 15

#fertilizer-to-water map:
#49 53 8
#0 11 42
#42 0 7
#57 7 4

#water-to-light map:
#88 18 7
#18 25 70

#light-to-temperature map:
#45 77 23
#81 45 19
#68 64 13

#temperature-to-humidity map:
#0 69 1
#1 0 69

#humidity-to-location map:
#60 56 37
#56 93 4
#EOF
input = input.split("\n\n")

# destination source length
maps = {}

seeds_line = input.shift
seeds_line =~ /((\d+ ?)+)/
seed_numbers = $1.split(' ').map(&:to_i)

input.each do |section|
  definition, *mappings = section.split("\n")

  definition =~ /^(\w+)-to-(\w+) map:$/
  source_key = $1.to_sym
  destination_key = $2.to_sym

  mappings.each do |mapping|
    destination, source, length = mapping.split(' ').map(&:to_i)
    maps[[source_key, source, source + length - 1]] = [destination_key, destination, destination + length - 1]
  end
end

locations = {}
lowest_location = nil

seed_numbers.each_slice(2).each do |seed_start, length|
  (seed_start).upto(seed_start + length - 1) do |seed|
    source_key = :seed
    source = seed

    loop do
      relevant_maps = maps.select {|k, v| k.first == source_key}

      relevant_maps.each do |source_pair, destination_pair|
        source_from, source_to = source_pair[1], source_pair[2]
        if source_from <= source && source_to >= source
          # prep for next iteration
          offset = source - source_from
          source = destination_pair[1] + offset
          source_key = destination_pair.first # this will become the source in next iteration
          break
        end
      end
      if relevant_maps.empty?
        #locations[seed] = source
        if lowest_location.nil?
          lowest_location = source
        else
          if lowest_location > source
            lowest_location = source
          end
        end
        break
      else
        source_key = relevant_maps.first.last.first # this will become the source in next iteration
      end
    end
  end
end

puts lowest_location
