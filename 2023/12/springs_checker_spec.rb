require 'spec_helper'
require_relative 'springs_checker'

describe SpringsChecker do
  describe '.valid?' do
    it { expect(SpringsChecker.valid?('###..##...####.####', '2,3,3,3,2')).to be false }
    it { expect(SpringsChecker.valid?('###...##.#..?.', '8,1')).to be false }
    it { expect(SpringsChecker.valid?('#..##.#########.###?', '1,1,1,2,2,3')).to be false }
    it { expect(SpringsChecker.valid?('#.#...#..#...#..#..?', '3,3,3,1,3')).to be false }
    it { expect(SpringsChecker.valid?('##..##..#...###...??', '1,4')).to be false }
    it { expect(SpringsChecker.valid?('.#.#.....#.##??.#?', '1, 1, 2, 1, 1, 2')).to be false }
    it { expect(SpringsChecker.valid?('.#...###.#.#?', '1, 4, 3')).to be false }
    it { expect(SpringsChecker.valid?('.??.###????.###????.###????.###????.###', '1,1,3,1,1,3,1,1,3,1,1,3,1,1,3')).to be true }
    it { expect(SpringsChecker.valid?('...........#.#.#?..??...?#.?.??..??...?#.?.??..??...?#.?.??..??...?#.', '1,1,3,1,1,3,1,1,3,1,1,3,1,1,3')).to be true }
  end
end
