require 'spec_helper'

describe Huia::Bootstrap::ClassObject do
  let(:klass) { described_class.new }

  it { should respond_to :superclass }
  it { should respond_to :superclass= }

  describe '#initialize' do
    it 'initializes the public instance method table' do
      expect(klass.get_ivar('publicInstanceMethods')).to be_empty
    end

    it 'initializes the private instance method table' do
      expect(klass.get_ivar('privateInstanceMethods')).to be_empty
    end
  end

  describe '#superclass' do
    context "When the superclass is not set" do
      it 'uses the singleton object' do
        expect(klass.superclass).to eq Huia::Bootstrap.singleton_object
      end
    end
  end
end
