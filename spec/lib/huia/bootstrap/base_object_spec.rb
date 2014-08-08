require 'huia/bootstrap/base_object'

describe Huia::Bootstrap::BaseObject do
  let(:basic_object) { described_class.new }
  subject { basic_object }

  it { should respond_to :get_ivar }
  it { should respond_to :set_ivar }

  describe '#get_ivar' do
    context "When asking for a non-existant ivar" do
      subject { -> { basic_object.get_ivar :foo } }
      it { should raise_error }
    end

    context "When asking for an ivar that has been set" do
      before  { basic_object.set_ivar :foo, :bar }
      subject { basic_object.get_ivar :foo }

      it { should eq :bar }
    end
  end
end
