#! /usr/bin/env ruby

inputs = File.read('12-input.txt').split(/\n/)
#inputs = <<-EOF
#start-A
#start-b
#A-c
#A-b
#b-d
#A-end
#b-end
#EOF
#inputs = inputs.split(/\n/)

connections = {}
inputs.each do |line|
  from, to = line.split('-')
  connections[from] ||= []
  connections[from] << to

  connections[to] ||= []
  connections[to] << from
end

def valid?(cave, path)
  counts = path.reduce({}) {|acc, c|
    if c.match?(/^[a-z]+$/)
      acc[c] ||= 0
      acc[c] += 1
    end
    acc
  }
  return false if counts['start'] == 1 && cave == 'start'
  return false if counts.values.uniq == [1, 2] && counts[cave] && counts[cave] > 0
  true
end

def enter(cave, path, connections)
  return (path + ['end']).flatten if cave == 'end'
  return nil unless valid?(cave, path)

  foo = connections[cave].map do |c|
    enter(c, path + [cave], connections)
  end
  foo.compact
end

paths = enter('start', [], connections)
puts paths.flatten.count {|s| s == 'start'}
