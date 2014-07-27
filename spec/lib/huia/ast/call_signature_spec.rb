require 'spec_helper'

describe Huia::AST::CallSignature do
  let(:sig)       { 'hello' }
  let(:args)      { [] }
  let(:signature) { described_class.new sig, args }
  subject { signature }

  its(:signature) { should eq sig }
  its(:arguments) { should eq args }

  describe "#concat_signature" do
    context "When the current signature takes an argument" do
      let(:sig)  { 'hello:' }
      let(:args) { [ 'world' ]}

      context "And the passed signature takes an argument" do
        let(:sig2) { described_class.new 'foot:', ['in mouth'] }

        it 'concats the signatures' do
          subject.concat_signature sig2
          expect(subject.signature).to eq 'hello:foot:'
          expect(subject.arguments).to eq [ 'world', 'in mouth' ]
        end
      end

      context "And the passed signature doesn't take an argument" do
        let(:sig2) { described_class.new 'foot' }

        it 'raises an exception' do
          expect { subject.concat_signature sig2 }.to raise_error
        end
      end
    end

    context "When the current signature doesn't take an argument" do
      let(:sig2) { :sig2 }

      it 'raises an exception' do
        expect { subject.concat_signature sig2 }.to raise_error
      end
    end
  end

  describe '#takes_argument?' do
    subject { signature.takes_argument? }

    context "When the method signature ends with a colon" do
      let(:sig) { 'hello:' }
      it { should eq true }
    end

    context "When the method signature doesn't end with a colon" do
      let(:sig) { 'hello' }
      it { should eq false }
    end
  end
end
