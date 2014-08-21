require 'spec_helper'

describe Huia::AST::Assignment do
  let(:node) { described_class.new :name, :value }
  subject    { node }

  it { should be_a Huia::AST::Node }
  it { should respond_to :value }
  it { should respond_to :value= }
  it { should respond_to :scope }
  it { should respond_to :scope= }
  it { should respond_to :variable }
  it { should respond_to :variable= }
  it { should respond_to :bytecode }
end
