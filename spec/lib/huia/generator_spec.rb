require 'spec_helper'

describe Huia::Generator do
  let(:generator) { Huia::Generator.new }
  subject { generator }

  specify "#push_huia_const" do
    expect(generator).to receive(:push_cpath_top)
    expect(generator).to receive(:find_const).with(:Huia)
    expect(generator).to receive(:find_const).with(:Core)
    expect(generator).to receive(:find_const).with(:MyAwesomeConstant)
    subject.push_huia_const :MyAwesomeConstant
  end

  describe "#huia_send" do
    specify "with no arguments" do
      expect(generator).to receive(:push_literal).with('myAwesomeMethod')
      expect(generator).to receive(:string_dup)
      expect(generator).to receive(:send).with(:__huia__send, 1)
      subject.huia_send 'myAwesomeMethod'
    end

    specify "with arguments" do
      expect(generator).to receive(:push_literal).with('myMethodNamed:is:')
      expect(generator).to receive(:string_dup)
      expect(generator).to receive(:send).with(:__huia__send, 3)
      expect { |b| subject.huia_send 'myMethodNamed:is:', 2, &b }.to yield_control
    end
  end

  specify "#push_huia_integer" do
    expect(generator).to receive(:push_huia_const).with(:Integer)
    expect(generator).to receive(:huia_send).with('createFromValue:', 1).and_yield(generator)
    expect(generator).to receive(:push_int).with(3)
    subject.push_huia_integer 3
  end

  specify "#push_huia_float" do
    expect(generator).to receive(:push_huia_const).with(:Float)
    expect(generator).to receive(:huia_send).with('createFromValue:', 1).and_yield(generator)
    expect(generator).to receive(:push_literal).with(3.0)
    subject.push_huia_float 3.0
  end

  specify "#push_huia_false" do
    expect(generator).to receive(:push_huia_const).with(:False)
    expect(generator).to receive(:huia_send).with('create')
    subject.push_huia_false
  end

  specify "#push_huia_true" do
    expect(generator).to receive(:push_huia_const).with(:True)
    expect(generator).to receive(:huia_send).with('create')
    subject.push_huia_true
  end

  specify "#push_huia_nil" do
    expect(generator).to receive(:push_huia_const).with(:Nil)
    expect(generator).to receive(:huia_send).with('create')
    subject.push_huia_nil
  end

  describe "#push_huia_array" do
    specify "an empty array" do
      expect(generator).to receive(:push_huia_const).with(:Array)
      expect(generator).to receive(:huia_send).with('createFromValue:', 1).and_yield(generator)
      expect(generator).to receive(:make_array).with(0)
      subject.push_huia_array 0
    end

    specify "a non-empty array" do
      expect(generator).to receive(:push_huia_const).with(:Array)
      expect(generator).to receive(:huia_send).with('createFromValue:', 1).and_yield(generator)
      expect(generator).to receive(:make_array).with(3)
      expect { |b| subject.push_huia_array 3, &b }.to yield_control
    end
  end

  specify "#push_huia_hash" do
    expect(generator).to receive(:push_huia_const).with(:Hash)
    expect(generator).to receive(:huia_send).with('create')
    subject.push_huia_hash
  end

  specify "#push_huia_string" do
    expect(generator).to receive(:push_huia_const).with(:String)
    expect(generator).to receive(:huia_send).with('createFromValue:', 1).and_yield(generator)
    expect(generator).to receive(:push_literal).with("foo")
    expect(generator).to receive(:string_dup)
    subject.push_huia_string "foo"
  end

  describe "#push_huia_closure" do
    specify "when the closure takes no arguments" do
      expect(generator).to receive(:push_huia_const).with(:Closure)
      expect(generator).to receive(:huia_send).with('create:', 1).and_yield(generator)
      expect(generator).to receive(:push_rubinius)
      expect(generator).to receive(:create_block).with(:block)
      expect(generator).to receive(:send_with_block).with(:lambda, 0, false)
      expect(generator).to receive(:dup)
      expect(generator).to receive(:push_literal).with(:@argumentNames)
      expect(generator).to receive(:push_huia_array).with(0)
      expect(generator).to receive(:send).with(:instance_variable_set, 2)
      expect(generator).to receive(:pop)
      subject.push_huia_closure :block, []
    end

    specify "with the closure takes arguments" do
      expect(generator).to receive(:push_huia_const).with(:Closure)
      expect(generator).to receive(:huia_send).with('create:', 1).and_yield(generator)
      expect(generator).to receive(:push_rubinius)
      expect(generator).to receive(:create_block).with(:block)
      expect(generator).to receive(:send_with_block).with(:lambda, 0, false)
      expect(generator).to receive(:dup)
      expect(generator).to receive(:push_literal).with(:@argumentNames)
      expect(generator).to receive(:push_huia_array).with(2).and_yield(generator)
      expect(generator).to receive(:push_huia_string).with('hello')
      expect(generator).to receive(:push_huia_string).with('kitty')
      expect(generator).to receive(:send).with(:instance_variable_set, 2)
      expect(generator).to receive(:pop)
      subject.push_huia_closure :block, [ 'hello', 'kitty' ]
    end
  end
end
