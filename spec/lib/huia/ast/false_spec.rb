require 'spec_helper'

describe Huia::AST::False do
  it { should be_a Huia::AST::Literal }
  its(:value) { should eq false }
end
