
require 'spec_helper'

describe Huia::AST::Expression do
  subject { described_class.new "" }

  it { should be_a Huia::AST::Literal }
end
