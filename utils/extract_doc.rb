require 'yaml'

class DocumentExtractor
  attr_accessor :source

  def initialize source
    @source = source
  end

  def doc_chunks
    chunks = [[]]

    match = false
    source.split("\n").each do |line|
      if m = /^\s*#\s(.*)/.match(line)
        match = true
        chunks.last.push m[1]
      elsif match
        match = false
        chunks.push []
      end
    end

    chunks
  end

  def format
    doc_chunks.map do |chunk|
      chunk.join("\n")
    end.join("\n\n")
  end

  def self.extract_file name
    snippet = File.basename(name).split('.')[0..-2].join('.')
    docs = ''

    rbfile = File.expand_path("../../lib/huia/core/#{snippet}.rb", __FILE__)
    if File.exist? rbfile
      docs << DocumentExtractor.new(File.read(rbfile)).format
    end

    docs << DocumentExtractor.new(File.read(name)).format

    docs
  end
end
