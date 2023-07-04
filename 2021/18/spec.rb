require 'rspec'

require_relative 'explode.rb'
require_relative 'split.rb'

RSpec.describe 'Commands' do
  describe Explode do
    {
      '[[[[[9,8],1],2],3],4]' => '[[[[0,9],2],3],4]',
      '[7,[6,[5,[4,[3,2]]]]]' => '[7,[6,[5,[7,0]]]]',
      '[[6,[5,[4,[3,2]]]],1]' => '[[6,[5,[7,0]]],3]',
      '[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]' => '[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]',
      '[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]' => '[[3,[2,[8,0]]],[9,[5,[7,0]]]]',
    }.each do |k, v|
      it 'explodes' do
        expect(Explode.run(k)).to eq(v)
      end
    end
  end

  describe Split do
    {
      10 => [5, 5],
      11 => [5, 6],
      12 => [6, 6],
    }.each do |k, v|
      it 'splits' do
        expect(Split.run(k)).to eq(v)
      end
    end
  end
end
