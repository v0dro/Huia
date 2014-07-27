require 'spec_helper'

describe Huia::AST::Exponentiation do
  subject     { described_class.new :left, :right }

  it { should be_a Huia::AST::BinaryOp }

  describe '#reduce' do
    it 'sends left.toThePowerOf: right' do
      expect(subject).to receive(:send_right_to_left).with('toThePowerOf:')
      subject.reduce
    end
  end

end
