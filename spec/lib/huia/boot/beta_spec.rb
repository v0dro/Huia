require 'spec_helper'

describe Huia::Boot::Beta do
  let(:klass) do
    Class.new do
      include Huia::Boot::Alpha
      extend Huia::Boot::Alpha
    end
  end
  subject { klass }

  describe '.included' do
    # TBH, I don't remember why it does this. But I'm specing it anywya
    # until I figure out why it should be removed.

    it 'maps instance methods to methods' do
      expect(klass.instance_variable_get :@instanceMethods).to be_nil
      klass.send :include, Huia::Boot::Beta
      expect(klass.instance_variable_get :@instanceMethods).to be_a(Huia::Boot::HashWithSuperAccess)
      expect(klass.instance_variable_get(:@instanceMethods).superhash).to eq(klass.instance_variable_get(:@methods))
    end

    it 'maps private instance methods to private methods' do
      expect(klass.instance_variable_get :@privateInstanceMethods).to be_nil
      klass.send :include, Huia::Boot::Beta
      expect(klass.instance_variable_get :@privateInstanceMethods).to be_a(Huia::Boot::HashWithSuperAccess)
      expect(klass.instance_variable_get(:@privateInstanceMethods).superhash).to eq(klass.instance_variable_get(:@privateMethods))
    end
  end

  describe '.extended' do
    it 'bootstraps ivars' do
      expect(klass).to receive(:__huia__bootstrap_ivars).and_call_original
      klass.send :extend, Huia::Boot::Beta
    end

    %w| get: set:to: definePrivateMethod:as: defineMethod:as: if:then: |.each do |method|
      it "defines private class method #{method.inspect}" do
        klass.send :extend, Huia::Boot::Beta
        expect(klass.instance_variable_get(:@privateMethods).keys).to include(method)
      end
    end

    it 'defines class method "sendMessage:withArgs:"' do
      klass.send :extend, Huia::Boot::Beta
      expect(klass.instance_variable_get(:@methods).keys).to include('sendMessage:withArgs:')
    end
  end

  describe '#__huia__send' do
    it 'uses defaultResponderFor:' do
      klass.send :extend, Huia::Boot::Beta
      expect do |block|
        klass.instance_variable_get(:@privateMethods)['defaultResponderFor:'] = proc { |*a| block.to_proc }
        klass.__huia__send('foo', 'bar')
      end.to yield_with_args('bar')
    end

    it 'raises NoMethodError when the method is unavailable' do
      klass.send :extend, Huia::Boot::Beta
      expect do
        klass.__huia__send('foo')
      end.to raise_error(NoMethodError)
    end

    it 'delegates to __huia__call' do
      klass.send :extend, Huia::Boot::Beta
      expect(klass).to receive(:__huia__call)
      klass.__huia__send('get:')
    end
  end

  describe 'Huia methods' do
    subject do
      klass.send :extend,  Huia::Boot::Beta
      klass.send :include, Huia::Boot::Beta
      klass
    end

    describe 'get:' do
      it 'returns the named instance variable' do
        expect(subject.__huia__send('get:', 'instanceMethods')).to equal(subject.instance_variable_get(:@instanceMethods))
      end
    end

    describe 'set:to:' do
      it 'sets the named instance variable' do
        mock = Object.new
        subject.__huia__send('set:to:', 'testVariable', mock)
        expect(subject.instance_variable_get(:@testVariable)).to equal(mock)
      end
    end

    describe 'definePrivateMethod:as:' do
      it 'adds the method to the private methods hash' do
        mock = Object.new
        subject.__huia__send('definePrivateMethod:as:', 'testMessage', mock)
        pmethods = subject.instance_variable_get(:@privateMethods)
        expect(pmethods).to have_key 'testMessage'
        expect(pmethods['testMessage']).to equal(mock)
      end
    end

    describe 'defineMethod:as:' do
      it 'adds the method to the methods hash' do
        mock = Object.new
        subject.__huia__send('defineMethod:as:', 'testMessage', mock)
        methods = subject.instance_variable_get(:@methods)
        expect(methods).to have_key 'testMessage'
        expect(methods['testMessage']).to equal(mock)
      end
    end

    describe 'undefinePrivateMethod:' do
      it 'sets the method to nil in the methods hash' do
        subject.__huia__send('undefinePrivateMethod:', 'get:')
        pmethods = subject.instance_variable_get(:@privateMethods)
        expect(pmethods).not_to have_key 'get:'
        expect(pmethods['get:']).to be_nil
      end
    end

    describe 'defaultResponderFor:' do
      it 'returns the closure in the methods hash' do
        drf     = subject.instance_variable_get(:@privateMethods)['defaultResponderFor:'].to_proc
        closure = subject.instance_exec(nil, 'sendMessage:withArgs:', &drf)
        expect(closure).to equal(subject.instance_variable_get(:@methods)['sendMessage:withArgs:'])
      end

      it 'returns the closure in the private methods hash' do
        drf     = subject.instance_variable_get(:@privateMethods)['defaultResponderFor:'].to_proc
        closure = subject.instance_exec(nil, 'get:', &drf)
        expect(closure).to equal(subject.instance_variable_get(:@privateMethods)['get:'])
      end
    end

    describe 'sendMessage:withArgs:' do
      it 'delegates to __huia__send' do
        expect(subject).to receive(:__huia__send).with('message:', 'args')
        closure = subject.instance_variable_get(:@methods)['sendMessage:withArgs:']
        subject.instance_exec('message:', ['args'], &closure)
      end
    end

    describe 'if:then:' do
      context "When the passed argument is truthy" do
        let(:arg) { Huia::Core.true }

        it 'calls the block with the argument' do
          expect do |block|
            subject.__huia__send('if:then:', arg, block.to_proc)
          end.to yield_with_args(arg)
        end
      end

      context "When the passed argument is falsy" do
        let(:arg) { Huia::Core.false }

        it "doesn't call the block" do
          expect do |block|
            subject.__huia__send('if:then:', arg, block.to_proc)
          end.not_to yield_control
        end
      end
    end
  end
end
