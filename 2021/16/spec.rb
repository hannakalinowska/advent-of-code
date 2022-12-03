require 'rspec'
require_relative '16/parser'

RSpec.describe Parser do
  subject { Parser.new }

  it '8A004A801A8002F478' do
    packet = '8A004A801A8002F478'
    expect(subject.decode(subject.to_binary(packet))).to eq({})
  end
end
