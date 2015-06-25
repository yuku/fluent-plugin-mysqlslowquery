# -*- coding:utf-8 -*-
# -*- mode:ruby -*-

Gem::Specification.new do |gem|
  gem.authors       = ["taka84u9"]
  gem.email         = ["taka84u9@gmail.com"]
  gem.description   = %q{Fluent input plugin for MySQL slow query log file.}
  gem.summary       = %q{Fluent input plugin for MySQL slow query log file.}
  gem.homepage      = "https://github.com/taka84u9/fluent-plugin-mysqlslowquery"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fluent-plugin-mysqlslowquery"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.6"
  gem.add_development_dependency "fluentd"
  gem.add_development_dependency "myslog"
  gem.add_runtime_dependency "fluentd"
  gem.add_runtime_dependency "myslog"
end
