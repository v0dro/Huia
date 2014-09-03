require 'spec_helper'

describe Huia::AST::CallSignature do
  let(:signature) { 'signature' }
  let(:node)      { described_class.new signature }
  subject         { node }

  it { should be_a Huia::AST::Node }
  it { should respond_to :signature }
  it { should respond_to :arguments }

  it 'has empty arguments' do
    expect(subject.arguments).to eq []
  end

  describe '#takes_argument?' do
    subject { node.takes_argument? }

    context "When the signature ends with a ':'" do
      let(:signature) { 'signature:' }

      it { should eq true }
    end

    context "When the signature doesn't end with a ':'" do
      it { should eq false }
    end
  end

  describe '#concat_signature' do
    let(:lhs)         { described_class.new l_signature, [1] }
    let(:l_signature) { 'lhs' }
    let(:rhs)         { described_class.new r_signature, [2] }
    let(:r_signature) { 'rhs' }
    let(:concat)      { lhs.concat_signature rhs }
    subject { -> { concat } }

    context "When the LHS signature takes no argument" do
      let(:l_signature) { 'final' }

      it { should raise_error }
    end

    context "When the LHS signature takes an argument" do
      let(:l_signature) { 'lhs:' }

      context "When the RHS signature takes no argument" do
        let(:r_signature) { 'rhs' }

        it { should raise_error }
      end

      context "When the RHS signature takes an argument" do
        before            { concat }
        subject           { lhs }
        let(:r_signature) { 'rhs:' }

        it 'has the correct signature' do
          expect(subject.signature).to eq 'lhs:rhs:'
        end

        it 'has the correct arguments' do
          expect(subject.arguments).to eq [1,2]
        end
      end
    end
  end
end
