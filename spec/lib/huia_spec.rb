require 'spec_helper'

describe Huia do
  it { should respond_to :lex }
  it { should respond_to :parse }

  describe '#lex' do
    let(:str) { 'Huia.print: "hello world\n"'}
    subject { Huia.lex source }

    context "When passed an IO" do
      let(:source) { StringIO.new str, 'r' }

      it "doesn't raise an error" do
        expect { subject }.not_to raise_error
      end

      it 'delegates to Huia::Lexer' do
        expect(Huia::Lexer).to receive(:new).with(str)
        subject
      end
    end

    context "When passed a string" do
      let(:source) { str }

      it "doesn't raise an error" do
        expect { subject }.not_to raise_error
      end

      it 'delegates to Huia::Lexer' do
        expect(Huia::Lexer).to receive(:new).with(str)
        subject
      end
    end
  end
end
