require 'spec_helper'

describe Huia::Core::Ruby do
  subject { described_class }

  it_behaves_like :huia_class

  describe 'Huia methods' do
    describe '.createFromConstant:' do

      subject { described_class.huia_send('createFromConstant:', Huia::Core.string(constant)) }
      context "When the constant has no namespace" do
        let(:constant) { 'String' }

        it 'wraps the constant' do
          expect(subject.to_ruby).to eq(String)
        end
      end

      context "When the constant has a namespace" do
        let(:constant) { 'Huia::Boot::Alpha' }

        it 'wraps the constant' do
          expect(subject.to_ruby).to eq(Huia::Boot::Alpha)
        end
      end

      context "When the constant doesn't exist" do
        let(:constant) { 'MyFakeConstantThatDoesntExist' }

        it 'raises an exception' do
          expect { subject }.to raise_error
        end
      end
    end

    describe '.createFromObject:' do
      subject { described_class.huia_send('createFromObject:', :foo) }

      it 'wraps the object' do
        expect(subject.to_ruby).to eq :foo
      end
    end

    describe 'Instance methods' do
      let(:object) { [1,2,3] }
      subject { described_class.huia_send("createFromObject:", object) }

      describe '#send:' do
        it 'calls the method on the wrapped object' do
          expect(subject.huia_send('send:', Huia::Core.string('size')).to_ruby).to eq(3)
        end
      end

      describe '#send:withArgs:' do
        it 'calls the method on the wrapped object, passing the supplied arguments' do
          expect(subject.huia_send('send:withArgs:', Huia::Core.string('push'), 13).to_ruby).to eq([1,2,3,13])
        end
      end

      describe '#send:withBlock:' do
        it 'calls the method on the wrapped object, passing the supplied block' do
          expect do |block|
            subject.huia_send('send:withBlock:', Huia::Core.string('each'), block.to_proc)
          end.to yield_successive_args(1,2,3)
        end
      end

      describe '#send:withArgs:andBlock:' do
        it 'calls the method on the wrapped object, passing the supplied arguments and block' do
          expect do |block|
            subject.huia_send('send:withArgs:andBlock:', Huia::Core.string('inject'), [:arg], block.to_proc)
          end.to yield_successive_args([:arg, 1], [nil, 2], [nil, 3])
        end
      end

      describe '#truthy?' do
        context "When the wrapped object is truthy" do
          let(:object) { true }

          it 'returns true' do
            expect(subject.huia_send('truthy?').to_ruby).to eq(true)
          end
        end

        context "When the wrapped object is falsy" do
          let(:object) { nil }

          it 'returns false' do
            expect(subject.huia_send('truthy?').to_ruby).to eq(false)
          end
        end
      end

      describe '#unwrap' do
        it 'returns the original object' do
          expect(subject.huia_send('unwrap')).to eq(object)
        end
      end

      describe '#toString' do
        it 'calls to_s on the original object' do
          expect(object).to receive(:to_s).and_return("great scott!")
          expect(subject.huia_send('toString').to_ruby).to eq("great scott!")
        end
      end

      describe '#toInteger' do
        it 'calls to_i on the original object' do
          expect(object).to receive(:to_i).and_return(123)
          expect(subject.huia_send("toInteger").to_ruby).to eq(123)
        end
      end

      describe '#toFloat' do
        it 'calls to_f on the original object' do
          expect(object).to receive(:to_f).and_return(1.23)
          expect(subject.huia_send('toFloat').to_ruby).to eq(1.23)
        end
      end

      describe '#toArray' do
        it 'calls to_a on the original object' do
          expect(object).to receive(:to_a).and_return([3,2,1])
          expect(subject.huia_send('toArray').to_ruby).to eq([3,2,1])
        end
      end

      describe '#toHash' do
        it 'calls to_h on the original object' do
          expect(object).to receive(:to_h).and_return({1 => 2, 3 => 4})
          expect(subject.huia_send('toHash').to_ruby).to eq({1 => 2, 3 => 4})
        end
      end

      describe '#toBoolean' do
        it 'calls truthy? on self' do
          # I tried to do this with message expectations, but that doesn't really
          # work with Huia. so damn.
          expect(subject.huia_send('toBoolean')).to eq(subject.huia_send('truthy?'))
        end
      end
    end
  end
end
