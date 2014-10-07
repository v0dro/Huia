# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'huia/version'

Gem::Specification.new do |spec|
  spec.name          = "huia"
  spec.version       = Huia::VERSION
  spec.authors       = ["James Harton"]
  spec.email         = ["james@resistor.io"]
  spec.summary       = %q{Huia is a whitespace-aware dynamic programming language targeting the Rubinius VM}
  spec.description   = <<EOF
Huia, is a programming language targetting the Rubinius VM.

Huia is a whitespace-aware dynamic language with a simple object model based around traditional inheritance and closures.
EOF
  spec.homepage      = "https://github.com/jamesotron/Huia"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"

  %w|
      rake pry rspec rspec-mocks oedipus_lex guard
      guard-rspec guard-rake guard-bundler racc rubinius-debugger
      codeclimate-test-reporter turnip rspec-its
    |.each do |gem|
    spec.add_development_dependency gem
  end

  %w| rubinius-bridge rubinius-toolset rubinius-compiler rubinius-ast |.each do |gem|
    spec.add_dependency gem
  end
end
