# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2019 Sebastian Katzer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

Gem::Specification.new do |spec|
  spec.name          = 'mruby_utils'
  spec.version       = '3.0.1'
  spec.authors       = ['Sebastián Katzer']
  spec.email         = ['katzer.sebastian@googlemail.com']

  spec.summary       = 'Utilities for developing mruby projects'
  spec.description   = 'Rake tasks and build helpers for mruby'
  spec.homepage      = 'https://github.com/katzer/mruby_utils'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/katzer/mruby_utils.git'
  spec.metadata['changelog_uri']   = 'https://github.com/katzer/mruby_utils/blob/master/CHANGELOG.md'

  spec.files         = Dir['lib/**/*']
  spec.require_paths = ['lib']

  spec.add_dependency 'rake', '>= 11.0.0'
  spec.add_development_dependency 'bundler'

  spec.required_ruby_version = '>= 2.0.0'
end
