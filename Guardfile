# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

guard 'rake', task: 'parser' do
  watch(%r{^lib/huia/lexer\.rex$})
  watch(%r{^lib/huia/lexer\.rb$})
  watch(%r{^lib/huia/parser\.y\.rb$})
end

