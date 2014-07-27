require 'spec_helper'

describe Huia::AST::Variable do
  subject { described_class.new :name, :value }

  it { should be_a Huia::AST::Literal }

  its(:name)  { should eq :name }
  its(:value) { should eq :value }
end
