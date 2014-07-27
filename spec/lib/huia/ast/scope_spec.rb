require 'spec_helper'

describe Huia::AST::Scope do
  subject { described_class.new }

  it { should be_a Huia::AST::Node }
  its(:variables) { should be_empty }

  describe '#allocate' do
    it 'returns a new Variable' do
      var = subject.allocate 'MyVariable'
      expect(var).to be_a(Huia::AST::Variable)
      expect(var.name).to eq 'MyVariable'
    end

    it 'stores a reference to the variable' do
      var = subject.allocate 'MyVariable'
      expect(subject.variables['MyVariable']).to eq var
    end
  end
end
