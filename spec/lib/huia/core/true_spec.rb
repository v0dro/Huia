require 'spec_helper'

describe Huia::Core::True do
  subject { described_class.huia_send('create') }

  it_behaves_like :huia_object

  its(:value) { should eq true }

  describe 'Huia methods' do

    describe '#inspect' do
      it 'returns "true"' do
        expect(subject.huia_send('inspect')).to eq(Huia::Core.string('true'))
      end
    end

    describe '#toString' do
      it 'returns "true"' do
        expect(subject.huia_send('toString')).to eq(Huia::Core.string('true'))
      end
    end

    describe '#unaryNot' do
      it 'returns false' do
        expect(subject.huia_send('unaryNot')).to eq(Huia::Core.false)
      end
    end
  end
end
