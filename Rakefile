require "bundler/gem_tasks"
Rake.application.rake_require "oedipus_lex"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
task :lexer => 'lib/huia/raw_lexer.rex.rb'
task :parser => [ :lexer, 'lib/huia/parser.y.rb' ] do
  sh 'racc -o lib/huia/parser.rb lib/huia/parser.y.rb'
end
task default: [ :parser, :spec ]
