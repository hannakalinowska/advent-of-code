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

def enter(cave, path, connections)
  return (path + ['end']).flatten if cave == 'end'
  return nil if path.include?(cave) && cave.match?(/^[a-z]+$/)

  foo = connections[cave].map do |c|
    enter(c, path + [cave], connections)
  end
  foo.compact
end

paths = enter('start', [], connections)
puts paths.flatten.count {|s| s == 'start'}
