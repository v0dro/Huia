require "bundler/gem_tasks"
Rake.application.rake_require "oedipus_lex"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:turnips) do |task|
  task.pattern = 'spec/acceptance/**/*.feature'
  task.rspec_opts = '-r turnip/rspec'
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

