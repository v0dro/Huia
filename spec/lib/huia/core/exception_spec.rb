require 'spec_helper'

describe Huia::Core::Exception do
  subject { described_class.huia_send('create') }

  it_behaves_like :huia_object

  it { should respond_to :backtrace }
  it { should respond_to :exception }

  describe '#exception' do
    its(:exception) { should be_a RuntimeError }
  end

  describe 'Huia methods' do

    describe '.createWithMessage:' do
      subject { described_class.huia_send('createWithMessage:', 'test message') }

      it 'creates an instance' do
        expect(subject).to be_a Huia::Core::Exception
      end

      it 'sets the message' do
        expect(subject.message).to eq 'test message'
      end
    end

    describe '.message' do
      subject { described_class.huia_send('createWithMessage:', 'test message') }

      it 'returns the message' do
        expect(subject.huia_send('message')).to eq 'test message'
      end
    end
  end
end
