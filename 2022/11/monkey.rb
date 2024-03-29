class Monkey
  attr_accessor :items, :count, :test_number

  def self.parse(input)
    items = []
    operation = nil
    test_number = nil
    true_target = nil
    false_target = nil
    input.split("\n").each do |line|
      case
      when line =~ /Starting items: (.+)$/
        items = $1.split(', ').map(&:to_i)
      when line =~ /Operation: (.+)$/
        operation = $1
      when line =~ /Test: divisible by (\d+)$/
        test_number = $1.to_i
      when line =~ /If true: throw to monkey (\d+)$/
        true_target = $1.to_i
      when line =~ /If false: throw to monkey (\d+)$/
        false_target = $1.to_i
      end
    end
    Monkey.new(items: items, operation: operation, test_number: test_number, true_target: true_target, false_target: false_target)
  end

  def initialize(items:, operation:, test_number:, true_target:, false_target:)
    @items = items
    @operation = operation
    @test_number = test_number
    @true_target = true_target
    @false_target = false_target
    @count = 0
  end

  def test(item, modulo)
    @count += 1
    if item % @test_number == 0
      [item % modulo, @true_target]
    else
      [item % modulo, @false_target]
    end
  end

  def operation(item)
    old = item
    eval(@operation)
  end
end
