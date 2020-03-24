# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reddit_archiver/version'

Gem::Specification.new do |spec|
  spec.name          = "reddit_archiver"
  spec.version       = RedditArchiver::VERSION
  spec.authors       = ["Timothy King"]
  spec.email         = ["tmk@lordzork.com"]
  spec.description   = "Reddit_archiver is a command line tool that will download all of the posts and comments from a given reddit account and store them in flat text files."
  spec.summary       = "A simple command line tool to archive the contents of a reddit account."
  spec.homepage      = "http://github.com/tmking/reddit_archiver"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "webmock", "~> 1.17.1"
  spec.add_runtime_dependency     "snoo", "~> 0.1.2"
  spec.add_runtime_dependency     "activesupport", "~> 4.1.0"
  spec.add_runtime_dependency     "htmlentities", "~> 4.3.1"
end
