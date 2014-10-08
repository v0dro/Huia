require 'spec_helper'

describe Huia::Core::Huia do
  subject { described_class }
  it_behaves_like :huia_class

  describe 'Huia methods' do

    describe '.requireFile:' do
      subject { described_class.huia_send('requireFile:', Huia::Core.string(file)) }

      context "When the file exists" do
        let(:file) { File.expand_path('../../../../fixtures/hello_world.huia', __FILE__) }

        it_behaves_like :huia_class

        it 'loads and evaluates the specified file' do
          expect(subject.huia_respond_to? 'whom:').to eq(true)
        end
      end

      context "When the file doesn't exist" do
        let(:file) { File.expand_path('../../../../fixtures/404.huia', __FILE__) }

        it 'raises an exception' do
          expect { subject }.to raise_error
        end
      end

      context "When the file contains a syntax error" do
        let(:file) { File.expand_path('../../../../fixtures/syntax_error.huia', __FILE__) }

        it 'raises an exception' do
          expect { subject }.to raise_error
        end
      end
    end

    describe '.requireCore:' do
      subject { described_class.huia_send('requireCore:', Huia::Core.string(file)) }

      context "When the file is an existing Huia::Core::<Constant>" do
        let(:file) { 'exception' }

        it 'returns the existing constant' do
          expect(subject).to eq(Huia::Core::Exception)
        end
      end

      context "When the file is present in `core`" do
        let(:file) { 'stdout' }

        it_behaves_like :huia_class

        it 'loads and evaluates the file' do
          expect(subject.huia_respond_to? 'putString:').to equal(true)
        end
      end

      context "When the file doesn't exist" do
        let(:file) { '404' }

        it 'raises an exception' do
          expect { subject }.to raise_error
        end
      end
    end

  end
end
