require 'spec_helper'

describe Huia::AST::String do
  subject { described_class.new "foo" }

  it { should be_a Huia::AST::Literal }
end
