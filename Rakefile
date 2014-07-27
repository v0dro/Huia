require "bundler/gem_tasks"
Rake.application.rake_require "oedipus_lex"

task :lexer => 'lib/huia/raw_lexer.rex.rb'
task :parser => [ :lexer, 'lib/huia/parser.y.rb' ] do
  sh 'racc -o lib/huia/parser.rb lib/huia/parser.y.rb'
end
