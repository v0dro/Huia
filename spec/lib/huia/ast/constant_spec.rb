require 'spec_helper'

describe Huia::AST::Constant do
  subject    { described_class.new 'Object' }

  it { should be_a Huia::AST::Literal }
end
