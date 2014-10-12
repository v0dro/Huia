require 'spec_helper'

describe Huia::Core::False do
  subject { described_class.huia_send('create') }

  it_behaves_like :huia_object

  its(:value) { should eq false }

  describe 'Huia methods' do

    describe '#inspect' do
      it 'returns "false"' do
        expect(subject.huia_send('inspect')).to eq(Huia::Core.string('false'))
      end
    end

    describe '#toString' do
      it 'returns "false"' do
        expect(subject.huia_send('toString')).to eq(Huia::Core.string('false'))
      end
    end

    describe '#truthy?' do
      it 'returns false' do
        expect(subject.huia_send('truthy?')).to eq(Huia::Core.false)
      end
    end

    describe '#unaryNot' do
      it 'returns true' do
        expect(subject.huia_send('unaryNot')).to eq(Huia::Core.true)
      end
    end
  end
end
