require 'spec_helper'

describe Huia::Core::Integer do
  subject { described_class.huia_send('createFromValue:', 13) }

  it_behaves_like :huia_object
  it { should be_a ::Huia::Core::Numeric }

  its(:value) { should eq 13 }

  describe 'Huia methods' do

    describe 'unaryComplement' do
      it 'returns the bitwise complement of the integer' do
        expect(subject.huia_send('unaryComplement').value).to eq(-14)
      end
    end

  end
end
