require 'spec_helper'

describe Huia::Boot::Gamma do
  let(:object) do
    Class.new do
      include Huia::Boot::Gamma
    end.new
  end
  subject { object }

  its(:huia?) { should eq true }

  describe '#huia_methods' do
    it 'returns a list of methods' do
      subject.instance_variable_set(:@methods, {a: 1, b: 2, c: 3})
      expect(subject.huia_methods).to eq([:a, :b, :c])
    end
  end

  describe '#huia_instance_methods' do
    it 'returns a list of methods' do
      subject.instance_variable_set(:@instanceMethods, {a: 1, b: 2, c: 3})
      expect(subject.huia_instance_methods).to eq([:a, :b, :c])
    end
  end

  describe '#huia_private_methods' do
    it 'returns a list of methods' do
      subject.instance_variable_set(:@privateMethods, {a: 1, b: 2, c: 3})
      expect(subject.huia_private_methods).to eq([:a, :b, :c])
    end
  end

  describe '#huia_private_instance_methods' do
    it 'returns a list of methods' do
      subject.instance_variable_set(:@privateInstanceMethods, {a: 1, b: 2, c: 3})
      expect(subject.huia_private_instance_methods).to eq([:a, :b, :c])
    end
  end

  describe '#huia_superclass' do
    it 'returns the @superclass ivar' do
      subject.instance_variable_set(:@superclass, :foo)
      expect(subject.huia_superclass).to equal(:foo)
    end
  end

  describe '#huia_class' do
    it 'returns the @class ivar' do
      subject.instance_variable_set(:@class, :foo)
      expect(subject.huia_class).to equal(:foo)
    end
  end

  describe '#huia_all_methods' do
    subject { object.huia_all_methods }

    before do
      %w| @methods @privateMethods @instanceMethods @privateInstanceMethods |.each do |ivar|
        object.instance_variable_set(ivar.to_sym, { rand => rand })
      end
    end

    it { should be_a Hash }

    %w| methods private_methods instance_methods private_instance_methods |.each do |type|
      its([type.to_sym]) { should eq object.public_send("huia_#{type}") }
    end
  end

  describe '#huia_respond_to?' do
    subject { object.huia_respond_to? 'prophecy0191' }

    context "When the method is present" do
      before { object.instance_variable_set(:@methods, {'prophecy0191' => :hello}) }
      it { should eq true }
    end

    context "When the method is not present" do
      before { object.instance_variable_set(:@methods, {}) }
      it { should eq false }
    end
  end

  describe '#huia_send' do
    it 'delegates to __huia__send' do
      expect(subject).to receive(:__huia__send).with('foo', 'bar')
      subject.huia_send('foo', 'bar')
    end
  end
end
