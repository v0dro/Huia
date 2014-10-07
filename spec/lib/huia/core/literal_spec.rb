require 'spec_helper'

describe Huia::Core::Literal do
  subject { described_class.huia_send('createFromValue:', 1) }

  it_behaves_like :huia_object

  it { should respond_to :value }
  it { should respond_to :to_ruby }
  it { should respond_to :eql? }
  it { should respond_to :hash }

  describe 'Huia methods' do
    describe '.createFromValue:' do
      subject { described_class.huia_send('createFromValue:', 1) }
      it_behaves_like :huia_object
      its(:value) { should eq 1 }
    end
  end
end
