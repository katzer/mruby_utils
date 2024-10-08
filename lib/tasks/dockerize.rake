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

desc 'create docker-compose.yml file'
task dockerize: 'docker-compose.yml'

file 'docker-compose.yml' do
  IO.write 'docker-compose.yml', <<~CONTENT
    services:
      compile: &defaults
        image: appplant/mruby-cli
        working_dir: /home/mruby/code
        volumes:
          - .:/home/mruby/code:rw
        environment:
          MRUBY_VERSION: ${MRUBY_VERSION}
        command: rake compile
      test:
        <<: *defaults
        command: rake test
      bintest:
        <<: *defaults
        command: rake test:bintest
      mtest:
        <<: *defaults
        command: rake test:mtest
      clean:
        <<: *defaults
        command: rake clean
      shell:
        <<: *defaults
        command: bash
      release:
        <<: *defaults
        command: rake release
  CONTENT
end
