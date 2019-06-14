# MRubyUtils

This gem adds some helpers to `MRuby::Build` and provides usefull Rake tasks to build __mruby__ binaries within a docker environment.

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'mruby_utils'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mruby_utils

## Rake tasks

Add this line to your applications's `Rakefile`:

```ruby
require 'mruby_utils/rake_tasks'
```

Now the following tasks are available:

    $ rake -T

    rake clean         # clean build artefacts
    rake compile       # compile binary
    rake dockerize     # create docker-compose.yml file
    rake release       # generate a release tarball
    rake shell         # open shell
    rake sshd          # start sshd
    rake test          # run all tests
    rake test:bintest  # run integration tests
    rake test:mtest    # run unit tests
    rake update        # update mruby and all mrbgems
    rake update:mgems  # update all git based mrbgems
    rake update:mruby  # update mruby
    rake version       # show version

Make sure to create a `docker-compose.yml` file before you start:

    $ rake dockerize

## Build helpers

Add this line to your applications's `build_config.rb`:

```ruby
require 'mruby_utils/build_helpers'
```

Now you can specify the required runtime version of glibc even the build compiles with a newer version.

```ruby
MRuby::Build.new('x86_64-pc-linux-gnu-glibc-2.12') do |conf|
  conf.glibc_version = '2.12'
end
```

Enable compiler optimizations:

```ruby
MRuby::Build.new('x86_64-pc-linux-gnu') do |conf|
  conf.enable_optimizations
end
```

Control how to link with libs:

```ruby
MRuby::Build.new('x86_64-pc-linux-gnu') do |conf|
  conf.static = true
end
```

In case the application uses `mruby-ssh` or `mruby-sftp`:

```ruby
MRuby::Build.new('x86_64-pc-linux-gnu') do |conf|
  conf.configure_libssh2(openssl: false, threading: true, zlib: true)
end
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/appplant/mruby_utils.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

Made with :yum: in Leipzig
