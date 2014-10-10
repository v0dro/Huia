require 'spec_helper'

describe Huia::Boot::HashWithSuperAccess do
  let(:superhash) { {} }
  let(:hash)      { described_class.new superhash }
  subject { hash }

  it { should respond_to :superhash }
  it { should respond_to :localhash }
  it { should respond_to :inspect }

  describe '#[]' do
    it 'delegates to localhash#fetch' do
      expect(subject.localhash).to receive(:fetch).with(:key)
      subject[:key]
    end

    it 'delegates to superhash#[] when localhash has no matching value' do
      expect(superhash).to receive(:[]).with(:key)
      subject[:key]
    end
  end

  describe '#[]=' do
    it 'sets the value on localhash' do
      subject[:key] = :value
      expect(subject.localhash).to have_key :key
      expect(subject.localhash[:key]).to equal(:value)
    end
  end

  describe '#fetch' do
    it 'delegates to localhash#fetch' do
      expect(subject.localhash).to receive(:fetch).with(:foo)
      subject.fetch(:foo)
    end

    it 'delegates to superhash#fetch when localhash#fetch fails' do
      expect(superhash).to receive(:fetch).with(:foo, :bar)
      subject.fetch(:foo, :bar)
    end
  end

  describe '#keys' do
    it 'merges the keys from localhash and superhash' do
      subject.localhash.merge!({a: 1, b: 2})
      subject.localhash.merge!({b: 2, c: 3})
      expect(subject.keys).to eq([:a, :b, :c])
    end
  end

  describe '#has_key?' do
    subject { hash.has_key? :foo }

    context "When the localhash contains the key" do
      before { hash.localhash[:foo] = 1 }

      it { should eq true }
    end

    context "When the superhash contains the key" do
      before { hash.superhash[:foo] = 1 }

      it { should eq true }
    end

    context "Otherwise" do
      it { should eq false }
    end
  end

  describe '#any?' do
    it 'delegates to localhash then superhash' do
      expect(subject.localhash).to receive(:any?)
      expect(subject.superhash).to receive(:any?)
      subject.any?
    end
  end

  describe '#method_missing' do
    it 'delegates unknown methods to localhash' do
      expect(subject.localhash).to receive(:unknown_method)
      subject.unknown_method
    end
  end

  describe '#freeze!' do
    it 'prevents modification' do
      subject.freeze!
      expect { subject[:foo] = :bar }.to raise_error
    end
  end

end
