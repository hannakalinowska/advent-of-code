require 'rspec'

require_relative 'list'

RSpec.describe List do
  describe '#move' do
    it 'moves through example' do
      input = [["352", 1], ["38b", 2], ["1af", -3], ["b5", 3], ["19d", -2], ["a5", 0], ["168", 4]]
      list = List.new(input.dup)
      expect(list.move(["352", 1])).to eq([["38b", 2], ["352", 1], ["1af", -3], ["b5", 3], ["19d", -2], ["a5", 0], ["168", 4]])
      expect(list.move(["38b", 2])).to eq([["352", 1], ["1af", -3], ["38b", 2], ["b5", 3], ["19d", -2], ["a5", 0], ["168", 4]])
      expect(list.move(["1af", -3])).to eq([["352", 1], ["38b", 2], ["b5", 3], ["19d", -2], ["1af", -3], ["a5", 0], ["168", 4]])
      expect(list.move(["b5", 3])).to eq([["352", 1], ["38b", 2], ["19d", -2], ["1af", -3], ["a5", 0], ["b5", 3], ["168", 4]])
      expect(list.move(["19d", -2])).to eq([["352", 1], ["38b", 2], ["1af", -3], ["a5", 0], ["b5", 3], ["168", 4], ["19d", -2]])
      expect(list.move(["a5", 0])).to eq([["352", 1], ["38b", 2], ["1af", -3], ["a5", 0], ["b5", 3], ["168", 4], ["19d", -2]])
      expect(list.move(["168", 4])).to eq([["352", 1], ["38b", 2], ["1af", -3], ["168", 4], ["a5", 0], ["b5", 3], ["19d", -2]])
    end

    it 'moves forward' do
      list = List.new([[:a, 1], [:b, 2], [:c, 3]])
      expect(list.move([:a, 1])).to eq([[:b, 2], [:a, 1], [:c, 3]])
    end

    it 'moves back' do
      list = List.new([[:a, 1], [:b, 2], [:c, -1]])
      expect(list.move([:c, -1])).to eq([[:a, 1], [:c, -1], [:b, 2]])
    end

    it 'wraps around forward' do
      list = List.new([[:a, 1], [:c, 3], [:b, 2], [:d, 4]])
      expect(list.move([:b, 2])).to eq([[:a, 1], [:b, 2], [:c, 3], [:d, 4]])
    end

    it 'wraps around backwards' do
      list = List.new([[:a, 1], [:b, -2], [:c, 3], [:d, 4]])
      expect(list.move([:b, -2])).to eq([[:a, 1], [:c, 3], [:b, -2], [:d, 4]])
    end
  end
end
