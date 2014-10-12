require 'spec_helper'

describe Huia::Core::Closure do
  subject { described_class.huia_send('create') }

  it_behaves_like :huia_object

  it { should respond_to :block }
  it { should respond_to :definedAt }
  it { should respond_to :arity }
  it { should respond_to :argument_names }
  it { should respond_to :defined_at }
  it { should respond_to :ensures }
  it { should respond_to :rescues }
  it { should respond_to :rescues_exception? }
  it { should respond_to :rescue_for }
  it { should respond_to :to_ruby }

  describe 'Huia methods' do

    let(:source) { "Closure.create: |a,b,c|\n  [a,b,c]\n"}
    subject { Huia.eval(source).invoke }

    describe '.create:' do
      context "When the passed argument is a Ruby proc" do
        it 'creates a new instance of the class' do
          expect(described_class.huia_send('create:', -> {})).to be_a(Huia::Core::Closure)
        end

        it 'assigns the passed block to the instance' do
          block = -> {}
          expect(described_class.huia_send('create:', block).block).to eq(block)
        end
      end

      context "When the passed block is a Huia Closure" do
        it 'returns the original instance' do
          closure = Huia::Core::Closure.huia_send('create:', -> {})
          expect(described_class.huia_send('create:', closure)).to eq(closure)
        end
      end
    end

    describe '#callWithSelf:andArgs:' do
      it 'executes the block' do
        expect do |block|
          described_class.huia_send('create:', block.to_proc).huia_send('callWithSelf:andArgs:', 1, [1,2,3])
        end.to yield_with_args(instance_of(Huia::Core::Closure), 1,2,3)
      end
    end

    describe '#takesArguments?' do
      context "When the closure takes arguments" do
        it 'is true' do
          expect(subject.huia_send('takesArguments?').to_ruby).to eq(true)
        end
      end

      context "When the closure takes no arguments" do
        let(:source) { "Closure.create:\n  true\n"}

        it 'is false' do
          expect(subject.huia_send('takesArguments?').to_ruby).to eq(false)
        end
      end
    end

    describe '#argumentNames' do
      context "When the closure takes arguments" do
        it 'is a list of argument names' do
          expect(subject.huia_send('argumentNames').to_ruby).to eq(['a','b','c'])
        end
      end

      context "When the closure takes no arguments" do
        let(:source) { "Closure.create:\n  true\n"}

        it 'is an empty list' do
          expect(subject.huia_send('argumentNames').to_ruby).to eq([])
        end
      end
    end

    describe '#takesArguments?' do
      context "When the closure takes arguments" do
        it 'is true' do
          expect(subject.huia_send('takesArguments?').to_ruby).to eq(true)
        end
      end

      context "When the closure takes no arguments" do
        let(:source) { "Closure.create:\n  true\n"}

        it 'is false' do
          expect(subject.huia_send('takesArguments?').to_ruby).to eq(false)
        end
      end
    end

    describe '#fileName' do
      it 'returns the source file of the block' do
        expect(subject.huia_send('fileName').to_ruby).to eq('(eval)')
      end
    end

    describe '#lineNumber' do
      it 'returns the line number of the block in the source file' do
        expect(subject.huia_send('lineNumber').to_ruby).to eq(0)
      end
    end

    describe '#rescueFrom:with:' do
      let(:source) { "Closure.create:\n  raiseException: (Huia.requireCore: 'exception') withMessage: 'WTF'\n" }

      it 'allows the closure to rescue a specific exception' do
        expect do |block|
          handler = Huia::Core::Closure.huia_send('create:', block.to_proc)
          subject.huia_send('rescueFrom:with:', Huia::Core::Exception, handler)
          subject.huia_send('callWithSelf:andArgs:', Huia::Core::Object.huia_send('create'), [1,2,3])
        end.to yield_with_args(instance_of(Huia::Core::Closure), instance_of(Huia::Core::Exception))
      end
    end

    describe '#ensure:' do
      context "When no exception is raised" do
        it 'calls the ensure block' do
          expect do |block|
            handler = Huia::Core::Closure.huia_send('create:', block.to_proc)
            subject.huia_send('ensure:', handler)
            subject.huia_send('callWithSelf:andArgs:', Huia::Core::Object.huia_send('create'), [1,2,3])
          end.to yield_with_args(instance_of(Huia::Core::Closure))
        end
      end

      context "When an exception is raised" do
        let(:source) { "Closure.create:\n  raiseException: (Huia.requireCore: 'exception') withMessage: 'WTF'\n" }

        it 'calls the ensure block' do
          expect do |block|
            handler = Huia::Core::Closure.huia_send('create:', block.to_proc)
            subject.huia_send('ensure:', handler)
            begin
            subject.huia_send('callWithSelf:andArgs:', Huia::Core::Object.huia_send('create'), [1,2,3])
            rescue
            end
          end.to yield_with_args(instance_of(Huia::Core::Closure))
        end
      end
    end

  end
end
