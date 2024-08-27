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

task 'mruby:tuneup' => 'mruby:environment' do
  MRuby.targets.keep_if do |name, spec|
    case "#{ARGV.join(' ')} local=#{ENV['MRUBY_CLI_LOCAL'].to_i}"
    when /local=1/ then name == 'host'
    when /compile/ then true
    when /bintest/ then spec.bintest_enabled?
    when /test/    then spec.bintest_enabled? || spec.test_enabled?
    else true
    end
  end

  MRuby.each_target
       .reject { |conf| conf.bintest_enabled? || conf.test_enabled? }
       .each { |conf| conf.mrbc.compile_options << ' --remove-lv' }

  task 'build' => MRuby.each_target.flat_map(&:products)
  task 'all' => 'mruby:all'

  rule '' do |t|
    mrb_task_name = t.name.sub('rake:', 'mruby:')

    if Rake::Task.task_defined? mrb_task_name
      Rake::Task[mrb_task_name].invoke
    else
      raise "Don't know how to build task '#{t.name}'"
    end
  end

  Rake::Task['mruby:gensym'].prerequisites.keep_if do |p|
    MRuby.targets.any? { |(target_name)| p.include? target_name }
  end
end
