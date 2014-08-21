require 'spec_helper'

describe Huia::AST::InterpolatedString do
  subject { described_class.new :child }
  it { should be_a Huia::AST::Expression }
end
