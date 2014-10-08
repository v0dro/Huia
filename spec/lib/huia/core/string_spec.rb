require 'spec_helper'

describe Huia::Core::String do
  subject { described_class.huia_send('createFromValue:', "hello world") }

  it_behaves_like :huia_literal

  it { should respond_to :to_str }
  it { should respond_to :to_s }
  its(:value) { should eq "hello world" }

  describe 'Huia methods' do
    describe 'concat:' do

      context "When the argument is a string" do
        it 'returns a new, concatenated string' do
          result = subject.huia_send('concat:', Huia::Core.string(' of warcraft'))
          expect(result.to_s).to eq("hello world of warcraft")
          expect(result).not_to equal(subject)
        end
      end

      context "When the argument is not a string" do
        it 'raises an exception' do
          expect { subject.huia_send('concat:', :foo) }.to raise_error
        end
      end
    end

    describe '#toString' do
      it 'returns self' do
        expect(subject.huia_send('toString')).to equal(subject)
      end
    end

    describe '#push:' do
      it 'appends other to self' do
        result = subject.huia_send('push:', Huia::Core.string(' of warcraft'))
        expect(result.to_s).to eq("hello world of warcraft")
        expect(result).to equal(subject)
      end
    end

    describe '#inspect' do
      it 'escapes the string for great justice' do
        expect(subject.huia_send('inspect').to_s).to eq('"hello world"')
      end
    end
  end
end
