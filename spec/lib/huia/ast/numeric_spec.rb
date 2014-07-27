require 'spec_helper'

describe Huia::AST::Numeric do
  subject { described_class.new "1" }

  it { should be_a Huia::AST::Literal }
end
