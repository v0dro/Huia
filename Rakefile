require "bundler/gem_tasks"
Rake.application.rake_require "oedipus_lex"
require "rspec/core/rake_task"
require File.expand_path('../utils/extract_doc', __FILE__)

RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:turnips) do |task|
  task.pattern = 'spec/acceptance/**/*.feature'
  task.rspec_opts = '-r turnip/rspec'
end

task :docs do
  Dir['core/**/*.huia'].each do |file|
    docs = DocumentExtractor.extract_file file

    snippet = File.basename(file).split('.')[0..-2].join('.')

    doc_filename = "docs/#{snippet[0].upcase}#{snippet[1..-1]}.md"

    unless docs.size == 0
      puts "Writing docs to #{doc_filename}"
      File.write doc_filename, docs
    end
  end
end

task :clean do
  Dir['**/*.huiac'].each do |file|
    `rm -v #{file}`
  end
end
task :lexer => 'lib/huia/lexer.rex.rb'
task :parser => [ :lexer, 'lib/huia/parser.racc' ] do
  sh 'racc -o lib/huia/parser.rb lib/huia/parser.racc'
end
# task suite: [ :spec, :turnips ]
task suite: [ :clean, :spec ]
task default: [ :parser, :suite ]

