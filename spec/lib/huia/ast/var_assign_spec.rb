require 'spec_helper'

describe Huia::AST::VarAssign do
  let(:right) { double :right }
  subject     { described_class.new left, right }

  context "When LHS is not a Huia::AST::Variable" do
    let(:left) { double :left }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end

  context "When RHS is a Huia::AST::Variable" do
    let(:left) { Huia::AST::Variable.new 'left' }

    it "doesn't raise an error" do
      expect { subject }.not_to raise_error
    end

    describe '#reduce' do
      it "reduces right and assigns to left" do
        expect(right).to receive(:reducible?).and_return(false)
        subject.reduce
        expect(left.value).to eq right
      end
    end
  end
end
