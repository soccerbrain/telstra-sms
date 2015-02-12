# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telstra/sms/version'

Gem::Specification.new do |spec|
  spec.name          = "telstra-sms"
  spec.version       = Telstra::Sms::VERSION
  spec.authors       = ["Paul Millar"]
  spec.email         = ["paul@digitaldawn.com.au"]
  spec.summary       = %q{Send SMS through the Telstra SMS API}
  spec.homepage      = "https://github.com/soccerbrain/telstra-sms"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end
