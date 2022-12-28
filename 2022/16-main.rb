#! /usr/bin/env ruby

input = File.read('16-input.txt')
#input = <<-EOF
#Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
#Valve BB has flow rate=13; tunnels lead to valves CC, AA
#Valve CC has flow rate=2; tunnels lead to valves DD, BB
#Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
#Valve EE has flow rate=3; tunnels lead to valves FF, DD
#Valve FF has flow rate=0; tunnels lead to valves EE, GG
#Valve GG has flow rate=0; tunnels lead to valves FF, HH
#Valve HH has flow rate=22; tunnel leads to valve GG
#Valve II has flow rate=0; tunnels lead to valves AA, JJ
#Valve JJ has flow rate=21; tunnel leads to valve II
#EOF
input = input.split("\n")

$valves = {}
input.each do |line|
  line =~ /Valve (\w+) has flow rate=(\d+); tunnels? leads? to valves? (.+)$/

  $valves[$1] = {
    flow_rate: $2.to_i,
    tunnels: $3.split(", "),
  }.freeze
end
$openable_valves = $valves.count {|k, v| v[:flow_rate] > 0}

class Path
  attr_reader :time_remaining, :path, :score, :open_valves

  def initialize(time_remaining, score, current_node, path, open_valves)
    #puts "Initialising path: #{time_remaining} (#{score}), #{current_node}, #{path.join('-')}"
    @time_remaining = time_remaining
    @score = score
    @current_node = current_node
    @path = path
    @open_valves = open_valves
  end

  def all_valves_open?
    @open_valves == $openable_valves
  end

  def find_neighbours
    neighbours = $valves[@current_node].fetch(:tunnels).dup
    current_node = $valves[@current_node]
    neighbours << :open if current_node[:flow_rate] > 0 && !@open_valves.include?(@current_node)
    neighbours
  end

  def move
    neighbours = find_neighbours
    neighbours.delete(path[-2]) if path[-1] != :open

    new_paths = neighbours.map do |neighbour|
      new_path = @path.dup + [neighbour]
      new_open_valves = @open_valves.dup
      new_current_node = neighbour
      new_score = @score
      if neighbour == :open
        new_open_valves << @current_node
        new_current_node = @current_node
        new_score += (@time_remaining - 1) * $valves[@current_node][:flow_rate]
      end
      Path.new(@time_remaining - 1, new_score, new_current_node, new_path, new_open_valves)
    end
    new_paths
  end
end

loop_count = 0
queue = []
full_paths = []
max_score_path = nil
max_scores_per_open_valves = {}
t = Time.now

start = Path.new(30, 0, 'AA', ['AA'], [])
queue.push(start)
loop do
  path = queue.shift

  if path.time_remaining > 0 && !path.all_valves_open?
    new_paths = path.move
    new_paths.each do |path|
      current_max_score = max_scores_per_open_valves[path.open_valves.sort] || 0
      if path.score >= current_max_score || current_max_score == 0
        max_scores_per_open_valves[path.open_valves.sort] = path.score
        queue.push(path)
      end
    end
  else
    full_paths << path
    if max_score_path.nil? || path.score > max_score_path.score
      max_score_path = path
    end
  end

  if loop_count % 100_000 == 0
    puts "Loop count: #{loop_count} Time: #{Time.now - t} Queue size: #{queue.size}"
    puts "Path time_remaining: #{path.time_remaining}"
    puts max_score_path.score if max_score_path
    t = Time.now
  end
  loop_count += 1
  break if queue.empty?
end
puts loop_count
puts max_score_path.score
