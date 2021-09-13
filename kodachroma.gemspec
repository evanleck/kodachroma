# frozen_string_literal: true
require_relative 'lib/kodachroma/version'

Gem::Specification.new do |spec|
  spec.name = 'kodachroma'
  spec.version = Kodachroma::VERSION
  spec.authors = ['Evan Lecklider', 'Jeremy Fairbank']
  spec.email = ['evan@lecklider.com']
  spec.summary = 'A library for color manipulation and palette generation.'
  spec.description = spec.summary
  spec.homepage = 'https://github.com/evanleck/kodachroma'
  spec.license = 'MIT'

  spec.files = Dir['lib/**/*', 'README.org', 'LICENSE.txt']
  spec.require_paths = ['lib']

  spec.metadata = {
    'bug_tracker_uri' => 'https://github.com/evanleck/kodachroma/issues',
    'source_code_uri' => 'https://github.com/evanleck/kodachroma'
  }

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-packaging'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
end
