#! /usr/bin/env ruby

input = File.read('07-input.txt')
#input = <<-EOF
#$ cd /
#$ ls
#dir a
#14848514 b.txt
#8504156 c.dat
#dir d
#$ cd a
#$ ls
#dir e
#29116 f
#2557 g
#62596 h.lst
#$ cd e
#$ ls
#584 i
#$ cd ..
#$ cd ..
#$ cd d
#$ ls
#4060174 j
#8033020 d.log
#5626152 d.ext
#7214296 k
#EOF
input = input.split("\n")

TOTAL_DISK_SPACE = 70_000_000
TOTAL_FREE_SPACE_NEEDED = 30_000_000

files = {}

current_path = []
input.each do |command|
  case command
  when /\$ cd \.\./
    current_path.pop
  when /\$ cd (.+)/
    dir = $1
    current_path << $1
  when /([0-9]+) (.+)/
    size = $1.to_i
    file = $2

    files[current_path.dup] ||= []
    files[current_path.dup] << size
  end
end

total_dir_sizes = {}
files.each do |path, f|
  sum = f.sum
  total_dir_sizes[path.dup] = sum
  if path.length > 1
    loop do
      path.pop

      total_dir_sizes[path.dup] ||= 0
      total_dir_sizes[path.dup] += sum

      break if path.length == 1
    end
  end
end

current_free_space = TOTAL_DISK_SPACE - total_dir_sizes[["/"]]
free_space_needed = TOTAL_FREE_SPACE_NEEDED - current_free_space
puts total_dir_sizes.select { |path, size| size >= free_space_needed }.values.min
