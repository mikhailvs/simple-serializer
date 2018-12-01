# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'serializer'

Gem::Specification.new do |s|
  s.name = 'simple-serializer'
  s.version = SimpleSerializer::VERSION
  s.authors = ['Mikhail Slyusarev']
  s.email = ['slyusarevmikhail@gmail.com']
  s.summary = 'Simple serializer. Easily serialize objects.'
  s.homepage = 'https://github.com/mikhailvs/simple-serializer'
  s.files = ['lib/serializer.rb']
  s.require_paths = ['lib']
  s.license = 'MIT'

  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'rubocop', '~> 0.60'
end
