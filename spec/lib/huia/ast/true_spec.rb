require 'spec_helper'

describe Huia::AST::True do
  it { should be_a Huia::AST::Literal }
  its(:value) { should eq true }
end
