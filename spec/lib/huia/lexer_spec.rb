require 'spec_helper'

describe Huia::Lexer do
  subject { described_class.new '' }
  its(:indent_level)  { should eq 0 }

  shared_examples_for :outdent do |n,x|
    let(:outdent_token) { [ :OUTDENT, '  ' ] }

    context "When sent #{n} tabs" do
      let(:text) { "\t" * n }
      it { should eq [ :OUTDENT, x ] }
    end
    context "When sent #{n * 2} spaces" do
      let(:text) { " " * n * 2 }
      it { should eq [ :OUTDENT, x ] }
    end
  end

  shared_examples_for :indent do |n,x|
    let(:indent_token)  { [ :INDENT, '  ' ] }

    context "When sent #{n} tabs" do
      let(:text) { "\t" * n }
      it { should eq [ :INDENT, x ] }
    end
    context "When sent #{n * 2} spaces" do
      let(:text) { " " * n * 2 }
      it { should eq [ :INDENT, x ] }
    end
  end

  describe "#in_or_out_dent" do
    let(:source) { '' }
    let(:lexer) { described_class.new(source) }
    subject { lexer.in_or_out_dent text }

    context "When the indent level is 3" do
      before { lexer.indent_level = 3 }

      0.upto(2).each do |i|
        it_behaves_like :outdent, i, 3 - i
      end
      4.upto(10).each do |i|
        it_behaves_like :indent, i, i - 3
      end
    end
  end

  describe 'Tokens' do

    shared_examples_for :token do |source,token,value=nil|
      describe source.inspect do
        let(:result) { Huia::Lexer.new(source).tokens.reject { |t| [:state, :EOF].member? t.first }.last }

        it "returns the #{token.inspect} token" do
          expect(result.size).to eq 2
          expect(result.first).to eq token
        end

        it "returns the #{value.inspect} value" do
          expect(result.last).to eq value
        end if value
      end
    end

    describe :INTEGER do
      { "0" => 0, "1" => 1, "123" => 123, "0x123f" => 4671, "0b10101" => 21 }.each do |source,value|
        it_behaves_like :token, source, :INTEGER, value
      end
    end

    describe :FLOAT do
      [ "0.0", "1.123", "9129.1992" ].each do |value|
        it_behaves_like :token, value, :FLOAT, value
      end
    end

    describe :STRING do
      ["hello", "hello world"].each do |value|
        it_behaves_like :token, "\"#{value}\"", :STRING, value
        it_behaves_like :token, "\'#{value}\'", :STRING, value
      end
    end

    describe :COMMENT do
      [ "hello # comment", "#comment" ].each do |value|
        it_behaves_like :token, value, :COMMENT
      end
    end

    describe :SIGNATURE do
      %w| lower: snake_case: camelCase: UpperCamelCase: UPPERCASE: |.each do |value|
        it_behaves_like :token, value, :SIGNATURE, value
      end
    end

    describe :IDENTIFIER do
      %w| lower snake_case camelCase UpperCamelCase UPPERCASE |.each do |value|
        it_behaves_like :token, value, :IDENTIFIER, value
      end
    end

    describe :SYMBOL do
      %w| lower snake_case camelCase UpperCamelCase UPPERCASE |.each do |value|
        it_behaves_like :token, ":#{value}", :SYMBOL, ":#{value}"
      end
    end

    describe 'in and outdent' do
      it 'calls the in_or_out_dent action method' do
        source = "\n  "
        lexer = Huia::Lexer.new source
        expect(lexer).to receive(:in_or_out_dent).with(source)
        lexer.tokens
      end
    end

    describe 'whitespace' do
      it 'is ignored' do
        source = "  "
        expect(Huia::Lexer.new(source).tokens.reject { |t| t[0] == :EOF }).to be_empty
      end
    end

    describe 'operators' do
      {
        "."  => :DOT,
        ":"  => :COLON,
        "="  => :EQUAL,
        "+"  => :PLUS,
        "-"  => :MINUS,
        "**" => :EXPO,
        "*"  => :ASTERISK,
        "/"  => :FWD_SLASH,
        "%"  => :PERCENT,
        "("  => :OPAREN,
        ")"  => :CPAREN
      }.each do |source,token|
        it_behaves_like :token, source, token
      end
    end

  end
end
