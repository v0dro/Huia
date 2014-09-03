require 'spec_helper'

describe Huia::AST::Nil do
  it { should be_a Huia::AST::Literal }

  specify "#value" do
    expect(subject.value).to eq nil
  end
end
