require 'spec_helper'

describe Huia::AST::Nil do
  it { should be_a Huia::AST::Literal }
  its(:value) { should eq nil }
end
