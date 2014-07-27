require 'spec_helper'

describe Huia::AST::Literal do
  subject { described_class.new :value }

  it { should be_a Huia::AST::Node }
  its(:value) { should eq :value }
end
