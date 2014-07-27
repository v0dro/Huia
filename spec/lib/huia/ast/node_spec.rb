require 'spec_helper'

describe Huia::AST::Node do
  it { should_not be_reducible }

  describe '#reduce' do
    it 'returns self' do
      node = described_class.new
      expect(node.reduce).to eq node
    end
  end

  describe '#call_method' do
    it 'debugs' do
      node = described_class.new
      expect(node).to receive(:puts)
      node.call_method :foo
    end
  end
end
