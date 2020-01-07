# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tianguis/version'

Gem::Specification.new do |spec|
  spec.name          = 'tianguis'
  spec.version       = Tianguis::VERSION
  spec.authors       = ['Luis Ezcurdia Razo']
  spec.email         = ['ing.ezcurdia@gmail.com']
  spec.license       = 'MIT'
  spec.summary       = 'Fetchs infro from Mexican Market Information System'
  spec.description   = 'Fetch data from National Market Information System of Mexico (SNIIM)'
  spec.homepage      = 'https://github.com/3zcurdia/tianguis'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3'

  spec.add_dependency 'faraday', '>=  0.10'
  spec.add_dependency 'nokogiri', '>= 1.10.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'vcr', '~> 5.0'
end
