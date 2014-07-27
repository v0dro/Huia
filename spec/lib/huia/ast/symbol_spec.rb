require 'spec_helper'

describe Huia::AST::Symbol do
  subject { described_class.new ":foo" }

  it { should be_a Huia::AST::Literal }
end
