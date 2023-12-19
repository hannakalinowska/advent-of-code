#! /usr/bin/env ruby

input = File.read('19-input.txt')
#input = <<EOF
#px{a<2006:qkq,m>2090:A,rfg}
#pv{a>1716:R,A}
#lnx{m>1548:A,A}
#rfg{s<537:gd,x>2440:R,A}
#qs{s>3448:A,lnx}
#qkq{x<1416:A,crn}
#crn{x>2662:A,R}
#in{s<1351:px,qqz}
#qqz{s>2770:qs,m<1801:hdj,R}
#gd{a>3333:R,R}
#hdj{m>838:A,pv}

#{x=787,m=2655,a=1222,s=2876}
#{x=1679,m=44,a=2067,s=496}
#{x=2036,m=264,a=79,s=2244}
#{x=2461,m=1339,a=466,s=291}
#{x=2127,m=1623,a=2188,s=1013}
#EOF
workflows, parts = input.split("\n\n")
workflows = workflows.split("\n")
parts = parts.split("\n")

class Part
  attr_reader :x, :m, :a, :s
  attr_reader :accepted
  def self.parse(line)
    line =~ /x=(\d+).+m=(\d+).+a=(\d+).+s=(\d+)/
    new(x: $1.to_i, m: $2.to_i, a: $3.to_i, s: $4.to_i)
  end

  def initialize(x:, m:, a:, s:)
    @x = x
    @m = m
    @a = a
    @s = s
    @accepted = nil
  end

  def to_s
    "{x=#{x},m=#{m},a=#{a},s=#{s}}"
  end

  def total
    x+m+a+s
  end

  def run(workflow)
    WORKFLOWS[workflow].each do |rule|
      if eval(rule[:condition])
        case rule[:outcome]
        when 'A'
          @accepted = true
          return
        when 'R'
          @accepted = false
          return
        else
          run(rule[:outcome])
          return
        end
      end
    end
  end
end

parts = parts.map {|p| Part.parse(p)}

WORKFLOWS = {}
workflows.each do |line|
  line =~ /^(\w+){(.+)}/
  name = $1
  WORKFLOWS[name] ||= []
  $2.split(',').each do |rule|
    if rule.include?(':')
      condition, outcome = rule.split(':')
    else
      condition = "true"
      outcome = rule
    end
    WORKFLOWS[name] << {condition: condition, outcome: outcome}
  end
end

parts.each do |part|
  part.run('in')
end

puts parts.select {|p| p.accepted == true}.sum(&:total)
