require 'spec_helper'

describe Huia::AST::Expression do
  let(:node) { described_class.new :child }
  subject    { node }

  it { should be_a Huia::AST::Node }

  it 'has the correct children' do
    expect(subject.children).to eq [ :child ]
  end

  describe '#append' do
    before { node.append :child2 }

    it 'has the correct children' do
      expect(subject.children).to eq [ :child, :child2 ]
    end
  end
end
