require 'spec_helper'

describe Huia::Core::Object do
  describe 'instance' do
    subject { described_class.huia_send('create') }

    it_behaves_like :huia_object
    its(:huia_class?)    { should eq false }
    its(:huia_instance?) { should eq true }

    %w| def:as: defineInstanceMethod:as: defp:as: definePrivateInstanceMethod:as:
        inspect isEqualTo: raiseException:withMessage: if:then: if:then:else:
        unless:then: respondsTo: class unaryNot truthy? falsy? isNotEqualTo:
        logicalOr: logicalAnd: |.each do |method|
      it "responds to #{method.inspect}" do
        expect(subject.huia_methods + subject.huia_private_methods).to include(method)
      end
    end
  end

  describe 'class' do
    subject { described_class }

    it_behaves_like :huia_class
    its(:huia_class?)    { should eq true }
    its(:huia_instance?) { should eq false }

    %w| def:as: defineInstanceMethod:as: defp:as: definePrivateInstanceMethod:as:
        inspect isEqualTo: raiseException:withMessage: if:then: if:then:else:
        unless:then: respondsTo: unaryNot truthy? falsy? isNotEqualTo:
        logicalOr: logicalAnd: extend: |.each do |method|
      it "responds to #{method.inspect}" do
        expect(subject.huia_methods + subject.huia_private_methods).to include(method)
      end
    end
  end
end
