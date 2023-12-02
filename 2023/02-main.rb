#! /usr/bin/env ruby

input = File.read('02-input.txt')
#input =<<EOF
#Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
#Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
#Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
#Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
#Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
#EOF
input = input.split("\n")

BAG = { red: 12, green: 13, blue: 14 }

class Draw
  attr_reader :blue, :red, :green

  def initialize(line)
    line.match(/(\d+) blue/)
    @blue = $1.to_i

    line.match(/(\d+) red/)
    @red = $1.to_i

   line.match(/(\d+) green/)
   @green = $1.to_i
  end

  def possible?
    @blue <= BAG[:blue] && @red <= BAG[:red] && @green <= BAG[:green]
  end
end

class Game
  attr_reader :id

  def initialize(line)
    line =~ /^Game (\d+): (.+)/
    @id = $1.to_i
    draws_line = $2.split(';')
    @draws = draws_line.map do |draw_line|
      Draw.new(draw_line)
    end
  end

  def possible?
    @draws.all?(&:possible?)
  end

  def power
    minimum_cubes.values.reduce(:*)
  end

  private

  def minimum_cubes
    return @minimum_cubes if defined?(@minimum_cubes)

    @minimum_cubes = { blue: 0, red: 0, green: 0 }
    @draws.each do |draw|
      if draw.blue > @minimum_cubes[:blue]
        @minimum_cubes[:blue] = draw.blue
      end
      if draw.red > @minimum_cubes[:red]
        @minimum_cubes[:red] = draw.red
      end
      if draw.green > @minimum_cubes[:green]
        @minimum_cubes[:green] = draw.green
      end
    end

    @minimum_cubes
  end
end

power = input.sum do |line|
  game = Game.new(line)
  game.power
end

puts power
