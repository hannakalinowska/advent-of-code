require 'rspec'
require_relative 'rope'

RSpec.describe Rope do
  describe '#move_tail' do
    subject { Rope.new([0, 0], tail) }

    describe 'same position' do
      let(:tail) { [0, 0] }

      it 'returns same tail' do
        expect(subject.move_tail).to eq(tail)
      end
    end

    describe 'distance of 1' do
      [
        [0, 1],
        [0, -1],
        [1, 0],
        [-1, 0],
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1],
      ].each do |t|
        let(:tail) { t }

        it "returns same tail for #{t}" do
          expect(subject.move_tail).to eq(tail)
        end
      end
    end

    describe 'same row' do
      {
        [0, 3] => [0, 1],
        [0, -4] => [0, -1],
      }.each do |t, result|
        it "returns #{t} => #{result}" do
          subject = Rope.new([0, 0], t)
          expect(subject.move_tail).to eq(result)
        end
      end
    end

    describe 'same column' do
      {
        [3, 0] => [1, 0],
        [-4, 0] => [-1, 0],
      }.each do |t, result|
        it "returns #{t} => #{result}" do
          subject = Rope.new([0, 0], t)
          expect(subject.move_tail).to eq(result)
        end
      end
    end

    describe 'diagonal' do
      {
        [3, 1] => [1, 0],
        [-4, 1] => [-1, 0],
        [1, 4] => [0, 1],
        [1, -3] => [0, -1],
      }.each do |t, result|
        it "returns #{t} => #{result}" do
          subject = Rope.new([0, 0], t)
          expect(subject.move_tail).to eq(result)
        end
      end
    end
  end
end
