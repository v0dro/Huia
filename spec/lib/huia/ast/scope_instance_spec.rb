require 'spec_helper'

describe Huia::AST::ScopeInstance do
  subject { described_class.new :scope }

  it { should respond_to :scope }
  its(:scope) { should eq :scope }
end
