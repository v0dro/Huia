require 'spec_helper'

describe Huia::AST::Float do
  subject { described_class.new 1.0 }
  it { should be_a Huia::AST::Numeric }
end
