require 'spec_helper'

describe Huia::AST::ScopeInstance do
  subject { described_class.new :scope }

  it { should respond_to :scope }

  specify "#scope" do
    expect(subject.scope).to eq :scope
  end
end
