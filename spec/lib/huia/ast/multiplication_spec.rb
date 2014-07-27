require 'spec_helper'

describe Huia::AST::Multiplication do
  subject     { described_class.new :left, :right }

  it { should be_a Huia::AST::BinaryOp }

  describe '#reduce' do
    it 'sends left.multiplyBy: right' do
      expect(subject).to receive(:send_right_to_left).with('multiplyBy:')
      subject.reduce
    end
  end

end
