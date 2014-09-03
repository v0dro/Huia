require 'spec_helper'

describe Huia::AST::String do
  let(:node) { described_class.new 'str' }
  subject    { node }

  it { should be_a Huia::AST::Literal }

  describe '#append' do
    before { node.append 'ing' }

    specify "#value" do
      expect(subject.value).to eq 'string'
    end
  end
end
