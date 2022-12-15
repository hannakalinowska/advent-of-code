class Sensor
  attr_reader :sensor_x, :sensor_y, :beacon_x, :beacon_y, :range

  def initialize(sensor_x, sensor_y, beacon_x, beacon_y)
    @sensor_x = sensor_x
    @sensor_y = sensor_y
    @beacon_x = beacon_x
    @beacon_y = beacon_y

    @range = distance(beacon_x, beacon_y)
  end

  def contains?(x, y)
    distance(x, y) <= @range
  end

  def distance(x, y)
    (@sensor_x - x).abs + (@sensor_y - y).abs
  end
end
