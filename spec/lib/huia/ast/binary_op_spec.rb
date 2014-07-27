require 'spec_helper'

describe Huia::AST::BinaryOp do
  let(:left)  { double :left }
  let(:right) { double :right }
  subject { described_class.new left, right }
  it { should be_a Huia::AST::Node }

  its(:left)  { should eq left }
  its(:right) { should eq right }

  describe '#send_right_to_left' do

    # This is a horrible spec. I hope that @hmaddocks has input on fixing it.
    it 'reduces left and right then calls the method on left' do
      expect(right).to receive(:reducible?).and_return(true)
      expect(right).to receive(:reduce).and_return(right)
      expect(left).to  receive(:reducible?).and_return(true)
      expect(left).to  receive(:reduce).and_return(left)
      expect(left).to  receive(:call_method).with(:foo, right)
      subject.send_right_to_left :foo
    end
  end
end
