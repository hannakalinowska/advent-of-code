#! /usr/bin/env ruby

input = File.read('16-input.txt')
input = <<-EOF
Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II
EOF
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
  attr_reader :time_remaining, :my_path, :elephant_path, :score, :open_valves

  def initialize(time_remaining:,
                 score:,
                 my_current_node:,
                 elephant_current_node:,
                 my_path:,
                 elephant_path:,
                 open_valves:)
    @time_remaining = time_remaining
    @score = score
    @my_current_node = my_current_node
    @elephant_current_node = elephant_current_node
    @my_path = my_path
    @elephant_path = elephant_path
    # We're using open valves as a hash key. Better make sure they're sorted and don't change.
    @open_valves = open_valves.sort.freeze
  end

  def all_valves_open?
    @open_valves.size == $openable_valves
  end

  def find_neighbours(node)
    neighbours = $valves[node].fetch(:tunnels).dup
    current_node = $valves[node]
    # Add the option of opening the valve if the current valve adds to the total score
    # and is not yet open
    neighbours << :open if current_node[:flow_rate] > 0 && !@open_valves.include?(node)
    neighbours
  end

  def move
    my_neighbours = find_neighbours(@my_current_node)
    # Stop going back and forth between two nodes, except when you're alternating
    # between moving and opening valves
    my_neighbours.delete(@my_path[-2]) if @my_path[-1] != :open && @my_path[-2] != :open

    elephant_neighbours = find_neighbours(@elephant_current_node)
    # Stop going back and forth between two nodes, except when you're alternating
    # between moving and opening valves
    elephant_neighbours.delete(@elephant_path[-2]) if @elephant_path[-1] != :open && @elephant_path[-2] != :open

    new_paths = my_neighbours.map do |my_neighbour|
      # We'll be forking reality to test out all the possibilities.
      # This is where we prepare this alternative reality.
      # First, let's copy some values
      new_score = @score
      new_open_valves = @open_valves.dup

      # Then, let's modify the values we want to test in the new reality
      # (in this case, move to the new node)
      my_new_path = @my_path.dup + [my_neighbour]
      my_new_current_node = my_neighbour
      # We need to make some extra changes if the new reality is opening a valve
      if my_neighbour == :open
        new_open_valves << @my_current_node
        # We're not actually moving so the current node stays the same
        my_new_current_node = @my_current_node
        # Definitely need to bump the score
        new_score += (@time_remaining - 1) * $valves[@my_current_node][:flow_rate]
      end
      # We need to also test out all elephant moves.
      # This is pretty much a copy of all the things we do for our own moves.
      # The code could probably be simpler.
      elephant_neighbours.map do |elephant_neighbour|
        # This one is not a copy. We don't want the elephant to be following our path,
        # and especially not when it's trying to open the same valves as us.
        # Skip this particular reality.
        if my_neighbour == :open && elephant_neighbour == :open &&
            @my_path[-1] == @elephant_path[-1]
          next
        end
        elephant_new_path = @elephant_path.dup + [elephant_neighbour]
        elephant_new_current_node = elephant_neighbour
        if elephant_neighbour == :open
          new_open_valves << @elephant_current_node
          elephant_new_current_node = @elephant_current_node
          new_score += (@time_remaining - 1) * $valves[@elephant_current_node][:flow_rate]
        end
        # Finally let's create this new reality
        Path.new(time_remaining: @time_remaining - 1,
                 score: new_score,
                 my_current_node: my_new_current_node,
                 elephant_current_node: elephant_new_current_node,
                 my_path: my_new_path,
                 elephant_path: elephant_new_path,
                 open_valves: new_open_valves)
      end
    end
    # We want a flat list. None of this nested, full of nils nonsense
    new_paths.flatten.compact
  end
end

def end_state?(path)
  path.time_remaining == 0  || # ran out of time
    path.all_valves_open? # opened all valves
end

def worth_exploring?(path)
  return false if end_state?(path)
  return false if path.time_remaining == 0 # ran out of time
  return false if path.all_valves_open? # opened all valves

  # We've opened these valves already with a higher score - skip this path
  current_max_score = $max_scores_per_open_valves[path.open_valves] || 0
  return false if path.score < current_max_score

  return false if $max_time_remaining_to_open_valves > path.time_remaining

  true
end

# TODO: Could we precalculate shortest paths to valves that need to be open,
# then only use those as neighbours, adding the right cost/path as needed?

loop_count = 0
# TEST: let's see if priority queues help here
# Higher number of open valves == higher priority
queues = {}
$openable_valves.downto(0) {|i| queues[i] = []}
seen_paths = {}
max_score_path = nil
$max_scores_per_open_valves = {}
$max_time_remaining_to_open_valves = 0
$max_valves_open = 0
t = Time.now

path = Path.new(time_remaining: 26,
                 score: 0,
                 my_current_node: 'AA',
                 elephant_current_node: 'AA',
                 my_path: ['AA'],
                 elephant_path: ['AA'],
                 open_valves: [])
queues[0].push(path)

loop do
  $openable_valves.downto(0) do |i|
    path = queues[i].shift
    break if path
  end
  # We're skipping paths for a bunch of conditions. We might end up with an empty queue
  #if path.nil?
  #  break
  #end

  # Skip path when we have already found a quicker way to open all the valves
  #if $max_time_remaining_to_open_valves > path.time_remaining
  #  next
  #end

  # End this path when we've run out of time, or when all the valves are open.
  # TODO: We're running out of memory. We need to be more conservative about
  # pushing things to the queue
  #if path.time_remaining > 0 && !path.all_valves_open?
  if worth_exploring?(path)
    new_paths = path.move
    new_paths.each do |path|
      #next unless worth_exploring?(path)
      if path.open_valves.size > $max_valves_open
        $max_valves_open = path.open_valves.size
      end
      current_max_score = $max_scores_per_open_valves[path.open_valves] || 0
      if path.score >= current_max_score || current_max_score == 0
        $max_scores_per_open_valves[path.open_valves] = path.score
        queues[path.open_valves.size].push(path)
      end
    end
  end
  if end_state?(path)
    # We're in an end state - either all valves are open or we ran out of time.
    # No need to check again.
    if $max_time_remaining_to_open_valves < path.time_remaining
      $max_time_remaining_to_open_valves = path.time_remaining
    end
    if max_score_path.nil? || path.score > max_score_path.score
      max_score_path = path
    end
  end

  if loop_count % 100_000 == 0
    puts "#{Time.now.to_s} Loop count: #{loop_count} Time: #{Time.now - t}"
    queue_sizes = queues.map {|i, q| "[#{i}] => #{q.size}"}.join("\n")
    puts "Queue sizes: \n#{queue_sizes}"
    puts "Quickest all valves open: #{$max_time_remaining_to_open_valves}"
    puts "Max valves open: #{$max_valves_open}"
    puts max_score_path.score if max_score_path
    t = Time.now
  end
  loop_count += 1
  break if queues.all? {|k, v| v.empty?}
end
puts loop_count
puts "Max score: #{max_score_path.score}"

require 'pry'; binding.pry
puts
