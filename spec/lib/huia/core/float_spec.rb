require 'spec_helper'

describe Huia::Core::Float do
  subject { described_class.huia_send('createFromValue:', 13) }

  it_behaves_like :huia_object
  it { should be_a ::Huia::Core::Numeric }

  its(:value) { should eq 13.0 }
end
