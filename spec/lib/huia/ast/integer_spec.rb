require 'spec_helper'

describe Huia::AST::Integer do
  subject { described_class.new "1" }

  it { should be_a Huia::AST::Numeric }
end
