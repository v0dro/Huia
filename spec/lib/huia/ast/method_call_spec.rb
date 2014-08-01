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

  describe '#reduce' do
    it 'debugs' do
      expect(subject).to receive(:puts)
      subject.reduce
    end
  end
end
