require 'spec_helper'

describe Huia::AST::True do
  it { should be_a Huia::AST::Literal }

  specify '#value' do
    expect(subject.value).to eq true
  end
end
