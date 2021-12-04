require_relative 'lazy'

module Lab42
  module File extend self

    def enumerate_on_file_writable path
      ::File.writable?( path ) ? Lab42::Lazy.once( path ) : Lab42::Lazy::Never
    end
    
    def enumerate_on_file_readable path
      ::File.readable?( path ) ? Lab42::Lazy.once( path ) : Lab42::Lazy::Never
    end
  end # module File
end # module Lab42
# SPDX-License-Identifier: Apache-2.0
