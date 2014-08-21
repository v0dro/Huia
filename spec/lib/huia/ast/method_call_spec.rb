require 'spec_helper'

describe Huia::AST::MethodCall do
  let(:node)  { described_class.new lhs, rhs }
  let(:lhs)   { :lhs }
  let(:rhs)   { Huia::AST::CallSignature.new 'signature' }
  subject     { node }

  it { should be_a Huia::AST::Node }

  context "When the RHS is a CallSignature" do
    its(:left)  { should eq lhs }
    its(:right) { should eq rhs }
  end

  context "When the RHS is not a CallSignature" do
    let(:rhs) { :rhs }
    subject   { -> { node }  }

    it { should raise_error }
  end
end
