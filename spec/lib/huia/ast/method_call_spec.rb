require 'spec_helper'

describe Huia::AST::MethodCall do
  let(:left)  { :left }
  let(:right) { Huia::AST::CallSignature.new 'helloWorld' }
  subject     { described_class.new left, right }

  it { should be_a Huia::AST::Node }

  context "When RHS isn't a call signature" do
    let(:right) { :right }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end

  context "When passed a block" do
    subject     { described_class.new left, right, block }

    context "When the block is not a Scope object" do
      let(:block) { :block }

      it 'raises an error' do
        expect { subject }.to raise_error
      end
    end

    context "When the block is a Scope object" do
      let(:block) { Huia::AST::Scope.new }

      its(:block) { should eq block }
    end
  end

  describe '#reduce' do
    it 'debugs' do
      expect(subject).to receive(:puts)
      subject.reduce
    end
  end
end
