require 'spec_helper'

describe Huia::AST::Node do
  it { should respond_to :file }
  it { should respond_to :file= }
  it { should respond_to :line }
  it { should respond_to :line= }

  describe '#pos' do
    let(:g) { double(:g) }

    it 'calls set_line on the generator' do
      subject.line = 123
      subject.file = 'foo'
      expect(g).to receive(:set_line).with(123)
      expect(g).to receive(:file=).with(:foo)
      subject.pos g
    end
  end
end
