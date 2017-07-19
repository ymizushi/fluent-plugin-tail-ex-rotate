require File.expand_path('../lib/fluent/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-tail-ex-rotate"
  gem.version       = "0.1.1"

  gem.authors       = ["Yuta Mizushima"]
  gem.licenses       = ["MIT"]
  gem.email         = ["mizushima@gmail.com"]
  gem.description   = %q{Extension of in_tail plugin to customize log rotate timing.}
  gem.summary       = %q{customize log rotate timing}
  gem.homepage      = "https://github.com/ymizushi/fluent-plugin-tail-ex-rotate"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.has_rdoc = false

  gem.required_ruby_version = '~> 2.1'

  gem.add_runtime_dependency("fluentd", ["~> 0.14"])

  gem.add_development_dependency("bundler", "~> 1.3")
  gem.add_development_dependency("test-unit-rr", "~> 1.0")
  gem.add_development_dependency("flexmock", "~> 1.3")
  gem.add_development_dependency("rake", ["~> 0.9"])
end
