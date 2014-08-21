require 'spec_helper'

describe Huia::AST::Expression do
  let(:node) { described_class.new :child }
  subject    { node }

  it { should be_a Huia::AST::Node }
  its(:children) { should eq [ :child ] }

  describe '#append' do
    before { node.append :child2 }

    its(:children) { should eq [ :child, :child2 ] }
  end
end
