# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faster_asset_compiler/version'

Gem::Specification.new do |spec|
  spec.name          = "faster_asset_compiler"
  spec.version       = FasterAssetCompiler::VERSION
  spec.authors       = ["Jorge Falcão"]
  spec.email         = ["falcao@intelie.com.br"]
  spec.description   = %q{}
  spec.summary       = %q{A simple and faster rails asset compiler - JRuby only!}
  spec.homepage      = "https://github.com/jlbfalcao/faster_asset_compiler"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
