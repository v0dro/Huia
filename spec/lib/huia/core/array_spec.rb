require 'spec_helper'

describe Huia::Core::Array do
  it_behaves_like :huia_object
  it { should be_an Enumerable }
  it { should respond_to :each }

  describe 'Huia methods' do
    let(:ary) { [1,2,3].map { |i| Huia::Core.integer i } }
    subject { described_class.huia_send('createFromValue:', ary) }

    describe '#toString' do
      it 'returns a Huia string' do
        expect(subject.huia_send('toString')).to be_a(Huia::Core::String)
      end

      it 'represents the array in a human readable form' do
        expect(subject.huia_send('toString').to_s).to eq '[ 1, 2, 3 ]'
      end
    end

    describe '#at:' do
      it 'returns the value at the given index' do
        expect(subject.huia_send('at:', Huia::Core.integer(1))).to eq(Huia::Core.integer(2))
      end
    end

    describe '#at:set:' do
      it 'sets the value at the given index' do
        expect { subject.huia_send('at:set:', Huia::Core.integer(1), Huia::Core.integer(99)) }.to \
          change { subject.huia_send('at:', Huia::Core.integer(1)) }.
          from(Huia::Core.integer(2)).
          to(Huia::Core.integer(99))
      end
    end

    describe '#push:' do
      it 'changes the length of the array' do
        expect { subject.huia_send('push:', Huia::Core.integer(99)) }.to \
          change { subject.value.size }.from(3).to(4)
      end

      it 'adds the item to the end of the array' do
        expect { subject.huia_send('push:', Huia::Core.integer(99)) }.to \
          change { subject.value[-1] }.
          from(Huia::Core.integer(3)).
          to(Huia::Core.integer(99))
      end
    end

    describe '#size' do
      it 'returns the number of elements in the array' do
        expect(subject.huia_send('size')).to eq(Huia::Core.integer(3))
      end
    end

    describe '#withEach:' do
      it 'yields each element to the supplied block' do
        expect do |probe|
          subject.huia_send('withEach:', probe.to_proc)
        end.to \
        yield_successive_args(*ary)
      end
    end

    describe '#inspect' do
      it 'returns a human readable string of the array' do
        expect(subject.huia_send('inspect')).to eq(Huia::Core.string('[ 1, 2, 3 ]'))
      end
    end
  end
end
