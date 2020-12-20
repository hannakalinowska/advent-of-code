require 'rspec'
require_relative 'tile'

describe Tile do
  let(:id) { '123' }
  let(:tile) { [
      "AB",
      "CD",
    ] }

  subject { Tile.new(id, tile) }

  describe '#flip_horizontally' do
    it 'works' do
      expect(subject.flip_horizontally.tile).to eq([
        "BA",
        "DC",
      ])
    end
  end

  describe '#flip_vertically' do
    it 'works' do
      expect(subject.flip_vertically.tile).to eq([
        "CD",
        "AB"
      ])
    end
  end

  describe '#rotate' do
    it 'works' do
      expect(subject.rotate.tile).to eq([
        "CA",
        "DB"
      ])
    end
  end
end
