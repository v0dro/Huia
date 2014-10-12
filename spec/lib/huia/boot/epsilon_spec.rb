require 'spec_helper'

describe Huia::Boot::Epsilon do
  let(:object) do
    Class.new do
      include Huia::Boot::Epsilon
    end.new
  end
  subject { object }

  describe '#define_method_as' do
    it 'defines a huia method on the receiver' do
      expect(subject).to receive(:__huia__send).
        with('defineMethod:as:', :method_name, instance_of(Proc))
      subject.define_method_as :method_name, &->{}
    end
  end

  describe '#define_instance_method_as' do
    it 'defines a huia instance method on the receiver' do
      expect(subject).to receive(:__huia__send).
        with('defineInstanceMethod:as:', :method_name, instance_of(Proc))
      subject.define_instance_method_as :method_name, &->{}
    end
  end
end
