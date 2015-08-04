Gem::Specification.new do |gem|
  gem.authors       = ["Yuku Takahashi"]
  gem.email         = ["taka84u9@gmail.com"]
  gem.description   = "Fluent input plugin for MySQL slow query log file."
  gem.summary       = "Fluent input plugin for MySQL slow query log file."
  gem.homepage      = "https://github.com/taka84u9/fluent-plugin-mysqlslowquery"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fluent-plugin-mysqlslowquery"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.7"
  gem.add_dependency "fluentd", [">= 0.12.0", "< 2"]
  gem.add_dependency "myslog", "~> 0.0"
end
