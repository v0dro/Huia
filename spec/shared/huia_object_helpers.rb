RSpec.shared_examples :huia_object do
  it { should be_a Huia::Core::Object }
  it { should respond_to :__huia__send }

  describe '.create' do
    it 'creates a new instance of the class' do
      klass = subject.class
      expect(klass.huia_respond_to?('create')).to eq true
      expect(klass.huia_send('create')).to be_a(klass)
    end
  end
end

RSpec.shared_examples :huia_class do
  its(:ancestors) { should include Huia::Core::Object }
  it { should respond_to :__huia__send }

  describe '.create' do
    it 'creates a new instance of the class' do
      expect(subject.huia_respond_to?('create')).to eq(true)
      expect(subject.huia_send('create')).to be_a(subject)
    end
  end
end
