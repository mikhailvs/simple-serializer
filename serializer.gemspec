# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'serializer'

Gem::Specification.new do |s|
  s.name = 'serializer'
  s.version = SimpleSerializer::VERSION
  s.authors = ['Mikhail Slyusarev']
  s.email = ['slyusarevmikhail@gmail.com']
  s.summary = 'Simple serializer.'
  s.homepage = 'https://github.com/mikhailvs/simple-serializer'
  s.files = ['lib/*.rb']
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
end
