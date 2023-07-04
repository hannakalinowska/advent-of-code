#! /usr/bin/env ruby

input = File.read('17-input.txt')
#input = <<-EOF
#target area: x=20..30, y=-10..-5
#EOF

class Range
  attr_reader :min_x, :max_x, :min_y, :max_y
  def initialize(input)
    puts input
    input =~ /x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)/

    @min_x = $1.to_i
    @max_x = $2.to_i
    @min_y = $3.to_i
    @max_y = $4.to_i
  end
  def missed?(probe)
    probe.x > @max_x || probe.y < @max_y
  end

  def hit?(probe)
    probe.x.between?(@min_x, @max_x) && probe.y.between?(@min_y, @max_y)
  end
end

class Probe
  attr_reader :x, :y, :max_y
  def initialize(x_velocity, y_velocity)
    @x = 0
    @y = 0
    @x_velocity = x_velocity
    @y_velocity = y_velocity

    @max_y = 0
  end

  def move
    calculate_new_position
    decrease_velocity
  end

  private

  def calculate_new_position
    @x += @x_velocity
    @y += @y_velocity
    #puts "Current position: #{@x}, #{@y}"
    @max_y = @y if @y > @max_y
  end

  def decrease_velocity
    case
    when @x_velocity > 0
      @x_velocity -= 1
    when @x_velocity < 0
      @x_velocity += 1
    end
    @y_velocity -= 1
  end
end

range = Range.new(input)
max_y = 0
count = 0

(-500 .. range.max_x).each do |x_velocity|
  (-500 .. 5151).each do |y_velocity|
    probe = Probe.new(x_velocity, y_velocity)

    loop do
      probe.move
      if range.hit?(probe)
        #puts "Hit"
        #puts probe.max_y
        max_y = probe.max_y if max_y < probe.max_y
        count += 1
        break
      end
      if range.missed?(probe)
        #puts "Missed"
        break
      end
    end
  end
end

puts max_y
puts count
