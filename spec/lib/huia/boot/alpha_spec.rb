require 'spec_helper'

module TestInspector
  def huia_methods
    @methods
  end

  def huia_private_methods
    @privateMethods
  end

  def huia_instance_methods
    @instanceMethods
  end

  def huia_private_instance_methods
    @privateInstanceMethods
  end
end

describe Huia::Boot::Alpha do
  let(:klass) do
    Class.new do
      extend Huia::Boot::Alpha
      extend TestInspector
    end
  end
  subject { klass }

  it { should respond_to :__huia__init }

  describe '__huia__bootstrap_ivars' do
    context "When called on a class" do
      it 'bootstraps the method table' do
        expect(subject.huia_methods).to be_nil
        subject.__huia__bootstrap_ivars
        expect(subject.huia_methods).to be_a(Huia::Boot::HashWithSuperAccess)
        expect(subject.huia_methods.size).to eq(0)
      end

      it 'bootstraps the private method table' do
        expect(subject.huia_private_methods).to be_nil
        subject.__huia__bootstrap_ivars
        expect(subject.huia_private_methods).to be_a(Huia::Boot::HashWithSuperAccess)
        expect(subject.huia_private_methods.size).to eq(0)
      end

      it 'bootstraps the instance method table' do
        expect(subject.huia_instance_methods).to be_nil
        subject.__huia__bootstrap_ivars
        expect(subject.huia_instance_methods).to be_a(Huia::Boot::HashWithSuperAccess)
        expect(subject.huia_instance_methods.size).to eq(0)
      end

      it 'bootstraps the private instance method table' do
        expect(subject.huia_private_instance_methods).to be_nil
        subject.__huia__bootstrap_ivars
        expect(subject.huia_private_instance_methods).to be_a(Huia::Boot::HashWithSuperAccess)
        expect(subject.huia_private_instance_methods.size).to eq(0)
      end
    end

    context "When called on an object" do
      subject do
        klass.new.tap do |o|
          o.send :extend, Huia::Boot::Alpha
          o.send :extend, TestInspector
        end
      end

      it 'bootstraps the method table' do
        expect(subject.huia_methods).to be_nil
        subject.__huia__bootstrap_ivars
        expect(subject.huia_methods).to be_a(Huia::Boot::HashWithSuperAccess)
        expect(subject.huia_methods.size).to eq(0)
      end

      it 'bootstraps the private method table' do
        expect(subject.huia_private_methods).to be_nil
        subject.__huia__bootstrap_ivars
        expect(subject.huia_private_methods).to be_a(Huia::Boot::HashWithSuperAccess)
        expect(subject.huia_private_methods.size).to eq(0)
      end

      it 'doesn\'t bootstrap the instance method table' do
        expect(subject.huia_instance_methods).to be_nil
        subject.__huia__bootstrap_ivars
        expect(subject.huia_instance_methods).to be_nil
      end

      it 'doesn\'t bootstrap the private instance method table' do
        expect(subject.huia_private_instance_methods).to be_nil
        subject.__huia__bootstrap_ivars
        expect(subject.huia_private_instance_methods).to be_nil
      end
    end
  end

  describe '__huia__define_private_method' do
    subject { klass.tap { |k| k.__huia__bootstrap_ivars } }

    it 'defines a private method' do
      expect(subject.huia_private_methods.size).to eq(0)
      subject.__huia__define_private_method('helloWorld', ->{})
      expect(subject.huia_private_methods.keys).to include('helloWorld')
    end
  end

  describe '__huia__define_method' do
    subject { klass.tap { |k| k.__huia__bootstrap_ivars } }

    it 'defines a method' do
      expect(subject.huia_methods.size).to eq(0)
      subject.__huia__define_method('helloWorld', ->{})
      expect(subject.huia_methods.keys).to include('helloWorld')
    end
  end

  describe '__huia__send' do
    subject { klass.tap { |k| k.__huia__bootstrap_ivars } }

    context "When the method exists" do
      it 'finds the method and passes it to __huia__call' do
        method_proc = ->{}
        arg = 1
        subject.__huia__define_method('helloWorld:', method_proc)
        expect(subject).to receive(:__huia__call).with(method_proc, subject, arg)
        subject.__huia__send('helloWorld:', arg)
      end
    end

    context "When the method is missing" do
      it 'raises an exception' do
        expect { subject.__huia__send('helloWorld') }.to raise_error
      end
    end
  end

  describe '__huia__call' do
    context "When passed an non-blockable object" do
      it 'raises an exception' do
        expect { subject.__huia__call :foo, :foo }.to raise_error
      end
    end

    context "When passed an actual Proc object" do
      it 'calls the proc' do
        expect do |block|
          subject.__huia__call block.to_proc, :foo, :bar
        end.to yield_with_args(:bar)
      end
    end

    context "When passed a Huia Closure object" do
      it 'dispatches to the closure' do
        closure = Huia::Core::Closure.huia_send('create:', -> {})
        expect(closure).to receive(:__huia__send).with('callWithSelf:andArgs:', :foo, [:bar])
        subject.__huia__call closure, :foo, :bar
      end
    end
  end
end
