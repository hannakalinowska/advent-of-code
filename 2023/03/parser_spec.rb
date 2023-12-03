require 'spec_helper'
require_relative 'parser'

describe Parser do
  let(:input) { %w(
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*24..
.664.598..
                )
  }

  describe '#extract_number' do
    it 'works when first digit' do
      expect(Parser.extract_number(2, 6, input)).to eq(633)
    end

    it 'works when middle of the number' do
      expect(Parser.extract_number(0, 2, input)).to eq(467)
    end
  end

  describe '#up' do
    it 'returns one number up' do
      expect(Parser.up(3, 6, input)).to eq([633])
    end

    it "returns a number diagonally" do
      expect(Parser.up(1, 3, input)).to eq([467])
    end

    it 'returns two numbers up' do
      #expect(Parser.up(3, 6, input)).to eq([633])
    end

    it 'returns empty array if end of board' do
      expect(Parser.up(0, 3, input)).to eq([])
    end
  end

  describe '#down' do
    it 'returns one number down' do
      expect(Parser.down(1, 3, input)).to eq([35])
    end

    it "returns a number diagonally" do
      expect(Parser.down(5, 5, input)).to eq([592])
    end

    it 'returns two numbers down' do
      #expect(Parser.down(3, 6, input)).to eq([633])
    end

    it 'returns empty array if end of board' do
      expect(Parser.down(3, 9, input)).to eq([])
    end
  end

  describe '#left' do
    it 'returns one number left' do
      expect(Parser.left(4, 3, input)).to eq([617])
    end

    it 'returns empty array at the boundary' do
      expect(Parser.left(1, 0, input)).to eq([])
    end
  end

  describe '#right' do
    it 'returns one number right' do
      expect(Parser.right(8, 5, input)).to eq([24])
    end

    it 'returns empty array at the boundary' do
      expect(Parser.right(3, 9, input)).to eq([])
    end
  end
end
