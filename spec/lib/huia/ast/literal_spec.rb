require 'spec_helper'

describe Huia::AST::Literal do
  let(:node)  { described_class.new value }
  let(:value) { :value }
  subject     { node }

  it { should be_a Huia::AST::Node }
  its(:value) { should eq value }
end
