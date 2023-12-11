require 'spec_helper'
require_relative 'tile'

describe Tile do
  describe '#follow' do
    let(:input) {
      <<~EOF
        7-F7-
        .FJ|7
        SJLL7
        |F--J
        LJ.LJ
      EOF
    }
    let(:i) { 0 }
    let(:j) { 2 }
    let(:tile) { Tile.new(i, j, input) }

    it 'works' do
      require 'pry'; binding.pry
      tile = tile.follow
      expect(tile.i).to eq()
      expect(tile.j).to eq()
    end
  end
end
