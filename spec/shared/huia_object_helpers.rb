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

RSpec.shared_examples :huia_literal do
  it_behaves_like :huia_object
  %w| to_ruby eql? == hash value |.each do |method|
    it { should respond_to method }
  end

  describe 'Huia methods' do
    it 'responds to #isEqualTo:' do
      expect(subject.huia_respond_to? 'isEqualTo:').to eq(true)
    end

    it 'responds to .createFromValue:' do
      expect(subject.class.huia_respond_to? 'createFromValue:').to eq(true)
    end
  end
end
