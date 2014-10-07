require 'spec_helper'

describe Huia::Core::Nil do
  subject { described_class.huia_send('create') }

  it_behaves_like :huia_object

  its(:value) { should eq nil }

  describe 'Huia methods' do

    describe '#inspect' do
      it 'returns "nil"' do
        expect(subject.huia_send('inspect')).to eq(Huia::Core.string('nil'))
      end
    end

    describe '#toString' do
      it 'returns ""' do
        expect(subject.huia_send('toString')).to eq(Huia::Core.string(''))
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
