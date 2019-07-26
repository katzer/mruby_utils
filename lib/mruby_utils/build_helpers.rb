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

module MRuby
  class Build
    # Enable compiler optimizations.
    #
    # @return [ Void ]
    def enable_optimizations
      [cc, cxx].each do |cc|
        cc.flags << (toolchains.include?('clang') ? '-Oz' : '-Os')
      end
    end

    alias enable_optimisations enable_optimizations

    # Set to true to enable static build instead of dynamic linking.
    #
    # @param [ Boolean ] value
    #
    # @return [ Void ]
    def static=(value)
      linker.flags_before_libraries << "-Wl,-B#{value ? 'static' : 'dynamic'}"
      linker.flags_after_libraries  << '-Wl,-Bdynamic'
    end

    # Set the proper include headers to ensure that the binary
    # wont depend on newer versions of glibc.
    #
    # param [ String ] version The maximun supported glibc version.
    #
    # @return [ Void ]
    def glibc_version=(version)
      return if !ENV['GLIBC_HEADERS'] || is_a?(CrossBuild)

      [cc, cxx].each do |cc|
        cc.flags << "-include #{ENV['GLIBC_HEADERS']}/x64/force_link_glibc_#{version}.h"
      end
    end

    # Configures how to compile libssh2.
    #
    # @param [ Symbol ] openssl    Link to openssl instead of mbedtls
    #                              Defaults to: false
    # @param [ Boolean ] threading Enable threading support
    #                              Defaults to: false
    # @param [ Boolean ] zlib      Enable zlib support
    #                              Defaults to: true
    # @param [ Boolean ] tiny      Build with tiny ssh support for sftp
    #                              Defaults to: false
    # @param [ Boolean ] debug     Build with debug flag and enable tracing
    #                              Defaults to: false
    # @param [ Boolean ] source    Github repo from where to download the source
    #
    # @return [ Void ]
    def configure_libssh2(openssl: false, threading: false, zlib: true, tiny: false, debug: false, source: nil)
      linker.libraries << 'crypto' if openssl

      [cc, cxx].each do |cc|
        cc.defines << 'MRB_SSH_TINY' if tiny
        cc.defines += %w[LIBSSH2_HAVE_ZLIB ZLIB_STATIC HAVE_UNISTD_H] if zlib
        cc.defines += %w[MRB_SSH_LINK_CRYPTO LIBSSH2_OPENSSL] if openssl
        cc.defines += %w[MBEDTLS_THREADING_PTHREAD MBEDTLS_THREADING_C] if threading
        cc.defines += %w[LIBSSH2DEBUG MRB_SSH_DEBUG] if debug
      end

      self.libssh2_source = source if source
    end

    # Override the github repo from where to download the libssh2 source code.
    #
    # @param [ String ] github A format like "account/repo#branch"
    #
    # @return [ Void ]
    def libssh2_source=(github)
      require File.join(gem_clone_dir, 'mruby-ssh/lib/ssh/downloader')
      SSH::Downloader.add_source :libssh2, github: github
    end
  end
end
