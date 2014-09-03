require 'spec_helper'

describe Huia::AST::False do
  it { should be_a Huia::AST::Literal }

  it 'has the correct value' do
    expect(subject.value).to eq false
  end
end
