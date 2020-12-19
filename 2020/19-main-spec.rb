require 'rspec'
require_relative '19-main'

describe Foo do
  before do
    subject.parse_inputs(inputs)
  end

  let(:inputs) {
    [
      '0: 4 1 5
1: 2 3 | 3 2
2: 4 4 | 5 5
3: 4 5 | 5 4
4: "a"
5: "b"',
'ababbb
abbbab
aaabbb
aaaabbb'
    ]
  }

  describe '#expand' do
    it 'returns ["a 2"]' do
      expect( subject.expand("4 2") ).to eq(["a 2"])
    end

    it 'returns ["a 4 4", "a 5 5"]' do
      expect( subject.expand("a 2") ).to eq(["a 4 4", "a 5 5"])
    end
  end

  describe '#step' do
    it 'works' do
      expect( subject.step(["a 2"]) ).to eq(["a 4 4", "a 5 5"])
    end

    it 'works' do
      expect( subject.step(["a 4 4", "a 5 5"]) ).to eq(["a a 4", "a b 5"])
    end

    it 'works' do
      expect( subject.step(["4 1 5"]) ).to eq(["a 1 5"])
      expect( subject.step(["a 1 5"]) ).to eq(["a 2 3 5", "a 3 2 5"])
      expect( subject.step(["a 2 3 5", "a 3 2 5"]) ).to eq([
        "a 4 4 3 5",
        "a 5 5 3 5",
        "a 4 5 2 5",
        "a 5 4 2 5",
      ])
      expect( subject.step([
        "a 4 4 3 5",
        "a 5 5 3 5",
        "a 4 5 2 5",
        "a 5 4 2 5",
      ]) ).to eq([
        "a a 4 3 5",
        "a b 5 3 5",
        "a a 5 2 5",
        "a b 4 2 5",
      ])
      expect( subject.step([
        "a a 4 3 5",
        "a b 5 3 5",
        "a a 5 2 5",
        "a b 4 2 5",
      ]) ).to eq([
        "a a a 3 5",
        "a b b 3 5",
        "a a b 2 5",
        "a b a 2 5",
      ])
      expect( subject.step([
        "a a a 3 5",
        "a b b 3 5",
        "a a b 2 5",
        "a b a 2 5",
      ]) ).to eq([
        "a a a 4 5 5",
        "a a a 5 4 5",
        "a b b 4 5 5",
        "a b b 5 4 5",
        "a a b 4 4 5",
        "a a b 5 5 5",
        "a b a 4 4 5",
        "a b a 5 5 5",
      ])
      expect( subject.step([
        "a a a 4 5 5",
        "a a a 5 4 5",
        "a b b 4 5 5",
        "a b b 5 4 5",
        "a a b 4 4 5",
        "a a b 5 5 5",
        "a b a 4 4 5",
        "a b a 5 5 5",
      ]) ).to eq([
        "a a a a 5 5",
        "a a a b 4 5",
        "a b b a 5 5",
        "a b b b 4 5",
        "a a b a 4 5",
        "a a b b 5 5",
        "a b a a 4 5",
        "a b a b 5 5",
      ])
      expect( subject.step([
        "a a a a 5 5",
        "a a a b 4 5",
        "a b b a 5 5",
        "a b b b 4 5",
        "a a b a 4 5",
        "a a b b 5 5",
        "a b a a 4 5",
        "a b a b 5 5",
      ]) ).to eq([
        "a a a a b 5",
        "a a a b a 5",
        "a b b a b 5",
        "a b b b a 5",
        "a a b a a 5",
        "a a b b b 5",
        "a b a a a 5",
        "a b a b b 5",
      ])
      expect( subject.step([
        "a a a a b 5",
        "a a a b a 5",
        "a b b a b 5",
        "a b b b a 5",
        "a a b a a 5",
        "a a b b b 5",
        "a b a a a 5",
        "a b a b b 5",
      ]) ).to eq([
        "a a a a b b",
        "a a a b a b",
        "a b b a b b",
        "a b b b a b",
        "a a b a a b",
        "a a b b b b",
        "a b a a a b",
        "a b a b b b",
      ])
    end
  end

  describe '#go!' do
    it 'works' do
      expect( subject.go!(["4 1 5"]) ).to eq([
        "a a a a b b",
        "a a a b a b",
        "a b b a b b",
        "a b b b a b",
        "a a b a a b",
        "a a b b b b",
        "a b a a a b",
        "a b a b b b",
      ])
    end
  end
end
