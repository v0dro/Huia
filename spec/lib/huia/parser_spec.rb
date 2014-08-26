require 'spec_helper'

describe Huia::Parser do
  let(:source) { '' }
  subject { Huia::Parser.new Huia::Lexer.new source, '(eval)' }

  it { should be_a Racc::Parser }
end
