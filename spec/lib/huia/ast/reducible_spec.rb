require 'spec_helper'

describe Huia::AST::Reducible do
  it { should be_a Huia::AST::Node }
  it { should be_reducible }

  describe '#reduce' do
    it 'raises an error' do
      node = described_class.new
      expect { node.reduce }.to raise_error
    end
  end
end
