require 'spec_helper'

describe Huia::CodeLoader do
  let(:file)        { 'example' }
  let(:working_dir) { Dir.mktmpdir }

  after { FileUtils.remove_entry working_dir }

  subject { described_class.new file, working_dir }

  def file_in_dir filename=file
    File.join(working_dir, filename)
  end

  its(:file) { should eq file }
  its(:wd)   { should eq working_dir }
  its(:path) { should eq file_in_dir }

  its(:uncompiled_filename) { should eq file_in_dir 'example.huia' }
  its(:compiled_filename) { should eq file_in_dir 'example.huiac' }

  describe "#load" do
    context "When there is no compiled file present" do
      before do
        File.write(file_in_dir('example.huia'), "true\n")
      end

      it 'compiles it' do
        expect { subject.load }.to change { File.exist? file_in_dir 'example.huiac' }.from(false).to(true)
      end
    end

    context "When there is a compiled file present" do
      context "And it is newer than the source" do
        before do
          File.write(file_in_dir('example.huia'), "true\n")
          subject.load
        end

        it 'does not recompile it' do
          expect { subject.load }.not_to change { File.stat(file_in_dir 'example.huiac').mtime }
        end
      end

      context "And it is older than the source" do
        before do
          File.write(file_in_dir('example.huia'), "true\n")
          subject.load
          sleep 1 # this sucks, but mtime has only per second resoltion.
          File.write(file_in_dir('example.huia'), "true\n")
        end

        it 'recompiles it' do
          expect { subject.load }.to change { File.stat(file_in_dir 'example.huiac').mtime }
        end
      end
    end

    context "When there is no file present at all" do
      it 'raises an error' do
        expect { subject.load }.to raise_error
      end
    end
  end
end
