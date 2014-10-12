require 'spec_helper'

describe Huia::Core::Numeric do
  subject { described_class.huia_send('createFromValue:', 13) }

  it_behaves_like :huia_object
  it { should be_a ::Huia::Core::Literal }

  its(:value)  { should eq 13 }
  its(:to_int) { should eq 13 }
  its(:to_f)   { should eq 13.0 }

  describe 'Huia methods' do
    let(:other_value) { 37.2 }
    let(:other) { described_class.huia_send('createFromValue:', other_value) }

    describe '#plus:' do
      it 'returns the sum of self and other' do
        expect(subject.huia_send('plus:', other).to_ruby).to eq(50.2)
      end
    end

    describe '#minus:' do
      it 'returns self minus other' do
        expect(subject.huia_send('minus:', other).to_ruby).to be_within(0.01).of(-24.2)
      end
    end

    describe '#multiplyBy:' do
      it 'returns self multiplied by other' do
        expect(subject.huia_send('multiplyBy:', other).to_ruby).to eq(483.6)
      end
    end

    describe '#divideBy:' do
      it 'returns self divided by other' do
        expect(subject.huia_send('divideBy:', other).to_ruby).to be_within(0.01).of(0.349)
      end
    end

    describe '#toThePowerOf:' do
      it 'returns self to the power of other' do
        expect(subject.huia_send('toThePowerOf:', other).to_ruby).to eq(2.745950510571778e+41)
      end
    end

    describe '#moduloOf:' do
      it 'returns the remainder of self divided by other' do
        expect(subject.huia_send('moduloOf:', other).to_ruby).to eq(13)
      end
    end

    describe '#unaryPlus' do
      it 'returns the unary plus of self' do
        expect(subject.huia_send('unaryPlus').to_ruby).to eq (13)
      end
    end

    describe '#unaryMinus' do
      it 'returns the unary plus of self' do
        expect(subject.huia_send('unaryMinus').to_ruby).to eq (-13)
      end
    end

    describe '#inspect' do
      it 'returns a string representation of self' do
        expect(subject.huia_send('inspect').to_ruby).to eq('13')
      end
    end

    describe '#toString' do
      it 'returns a string representation of self' do
        expect(subject.huia_send('toString').to_ruby).to eq('13')
      end
    end

    describe '#isGreaterThan:' do
      context "When self is greater than other" do
        let(:other_value) { 3 }

        it 'returns true' do
          expect(subject.huia_send('isGreaterThan:', other).to_ruby).to eq(true)
        end
      end

      context "When self is equal to other" do
        let(:other_value) { 13 }

        it 'returns false' do
          expect(subject.huia_send('isGreaterThan:', other).to_ruby).to eq(false)
        end
      end

      context "When self is less than other" do
        it 'returns false' do
          expect(subject.huia_send('isGreaterThan:', other).to_ruby).to eq(false)
        end
      end
    end

    describe '#isLessThan:' do
      context "When self is greater than other" do
        let(:other_value) { 3 }

        it 'returns false' do
          expect(subject.huia_send('isLessThan:', other).to_ruby).to eq(false)
        end
      end

      context "When self is equal to other" do
        let(:other_value) { 13 }

        it 'returns false' do
          expect(subject.huia_send('isLessThan:', other).to_ruby).to eq(false)
        end
      end

      context "When self is less than other" do
        it 'returns true' do
          expect(subject.huia_send('isLessThan:', other).to_ruby).to eq(true)
        end
      end
    end

    describe '#isGreaterOrEqualTo:' do
      context "When self is greater than other" do
        let(:other_value) { 3 }

        it 'returns true' do
          expect(subject.huia_send('isGreaterOrEqualTo:', other).to_ruby).to eq(true)
        end
      end

      context "When self is equal to other" do
        let(:other_value) { 13 }

        it 'returns true' do
          expect(subject.huia_send('isGreaterOrEqualTo:', other).to_ruby).to eq(true)
        end
      end

      context "When self is less than other" do
        it 'returns false' do
          expect(subject.huia_send('isGreaterOrEqualTo:', other).to_ruby).to eq(false)
        end
      end
    end

    describe '#isLessOrEqualTo:' do
      context "When self is greater than other" do
        let(:other_value) { 3 }

        it 'returns false' do
          expect(subject.huia_send('isLessOrEqualTo:', other).to_ruby).to eq(false)
        end
      end

      context "When self is equal to other" do
        let(:other_value) { 13 }

        it 'returns true' do
          expect(subject.huia_send('isLessOrEqualTo:', other).to_ruby).to eq(true)
        end
      end

      context "When self is less than other" do
        it 'returns true' do
          expect(subject.huia_send('isLessOrEqualTo:', other).to_ruby).to eq(true)
        end
      end
    end

  end
end
