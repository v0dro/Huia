require 'spec_helper'

describe Huia::AST::DefSignature do
  let(:sig)       { 'hello' }
  let(:args)      { [] }
  let(:signature) { described_class.new sig, args }
  subject { signature }

  its(:signature) { should eq sig }
  its(:arguments) { should eq args }

  context "When the argument is not a VarAssign" do
    let(:sig)  { 'hello:' }
    let(:args) { [ 'World' ] }

    it 'raises an error' do
      expect { subject }.to raise_error
    end
  end
end
