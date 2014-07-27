require 'spec_helper'

describe Huia::AST::Addition do
  subject     { described_class.new :left, :right }

  it { should be_a Huia::AST::BinaryOp }

  describe '#reduce' do
    it 'sends left.plus: right' do
      expect(subject).to receive(:send_right_to_left).with('plus:')
      subject.reduce
    end
  end

end
