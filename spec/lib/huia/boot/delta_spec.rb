require 'spec_helper'

class MockScript
  def initialize block=(-> {})
    @block = block
  end

  def closure
    self
  end

  def block
    @block
  end
end

describe Huia::Boot::Delta do
  let(:core_path) { File.expand_path('../../../../../core/', __FILE__) }
  let(:klass) do
    Class.new do
      include Huia::Boot::Alpha
      extend  Huia::Boot::Alpha
      include Huia::Boot::Beta
      extend  Huia::Boot::Beta
      extend  Huia::Boot::Delta

      def self.to_s
        'ExampleClass'
      end
    end
  end
  subject { klass }

  describe '#__huia__load_core' do
    it 'attempts to load the related core file' do
      expect(Huia).to receive(:load).with("example_class", core_path).and_return(MockScript.new)
      subject.__huia__load_core
    end

    it 'evaluates the block into the class context' do
      context = nil
      block = proc do
        context = self
      end
      allow(Huia).to receive(:load).with("example_class", core_path).and_return(MockScript.new(block))
      subject.__huia__load_core
      expect(context).to equal(subject)
    end
  end

  describe '#__huia__freeze_methods!' do
    %w| methods privateMethods instanceMethods privateInstanceMethods |.each do |var|
      context "When @#{var} is set" do
        it "calls #freeze! on @#{var}" do
          mock = Object.new
          subject.instance_variable_set("@#{var}".to_sym, mock)
          expect(mock).to receive(:freeze!)
          subject.__huia__freeze_methods!
        end
      end

      context "When @#{var} is not set" do
        it "doesn't raise an exception" do
          expect { subject.__huia__freeze_methods! }.not_to \
            raise_error
        end
      end
    end
  end
end
