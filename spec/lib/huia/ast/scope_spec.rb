require 'spec_helper'

describe Huia::AST::Scope do
  let(:parent)    { double :parent }
  subject         { described_class.new parent }

  it { should be_a Huia::AST::Node }
  its(:variables) { should be_empty }
  its(:children)  { should be_empty }
  its(:parent)    { should eq parent }

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

  describe '#append' do
    context 'When the argument is not a Node' do
      it 'raises an error' do
        expect { subject.append :foo }.to raise_error
      end
    end

    context "When the argument is a Node" do
      let(:arg) { Huia::AST::Integer.new(1) }

      it 'appends the argument to children' do
        subject.append arg
        expect(subject.children).to include arg
      end
    end
  end

  describe '#reduce' do
    it 'iterates through all children, calling reduce on each' do
      child1 = Huia::AST::Integer.new(1)
      child2 = Huia::AST::Integer.new(2)
      subject.append child1
      subject.append child2

      expect(child1).to receive(:reduce)
      expect(child2).to receive(:reduce)

      subject.reduce
    end
  end
end
