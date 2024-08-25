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

desc 'generate a release tarball'
task release: 'environment' do
  if in_a_docker_container? || ENV['MRUBY_CLI_LOCAL']
    Rake::Task['compile'].invoke

    spec         = MRuby::Gem.current
    version      = spec.version || 'unknown'
    release_dir  = "releases/v#{version}"
    release_path = File.join(pwd, release_dir)
    app_name     = "#{spec.name}-#{version}"

    mkdir_p release_path

    MRuby.each_target do
      bin  = "#{build_dir}/bin/#{exefile(spec.name)}"
      arch = "#{app_name}-#{name}"

      next unless File.exist? bin

      mkdir_p name
      cp bin, name

      sh "tar czf #{release_path}/#{arch}.tgz #{name}"

      rm_rf name
    end
  else
    docker_run 'release'
  end
end
