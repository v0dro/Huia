require 'spec_helper'

describe Huia::AST::Lambda do
  let(:scope)  { double :scope }
  let(:_lambda) { described_class.new scope }
  subject      { _lambda }

  it { should respond_to :arguments }
  it { should respond_to :default_values }
  its(:arguments)      { should eq [] }
  its(:default_values) { should eq [] }
  its(:scope)          { should eq scope }
  its(:arity)          { should eq 0 }

  describe "#append_argument" do
    context "When passed a variable without a default value" do
      let(:var) { double :variable }
      before    { _lambda.append_argument var }

      its(:arity)     { should eq 1 }
      its(:arguments) { should include var }
    end

    context "When passed a variable with a default value" do
      let(:var)   { double :variable }
      let(:value) { double :value }
      before      { _lambda.append_argument var, value }

      its(:arity)          { should eq 1 }
      its(:arguments)      { should include var }
      its(:default_values) { should include value }
    end
  end
end
