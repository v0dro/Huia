# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huia/version'

Gem::Specification.new do |spec|
  spec.name          = "huia"
  spec.version       = Huia::VERSION
  spec.authors       = ["James Harton"]
  spec.email         = ["james@resistor.io"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"

  %w|
      rake pry rspec rspec-its rspec-mocks oedipus_lex guard
      guard-rspec guard-rake guard-bundler racc
    |.each do |gem|
    spec.add_development_dependency gem
  end

  %w| rubinius-compiler |.each do |gem|
    spec.add_dependency gem
  end
end
