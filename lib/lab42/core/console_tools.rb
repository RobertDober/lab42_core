# No Namespaces Here

require_relative '../core'
require_relative 'fn'
require_relative 'b'
Dir.glob File.expand_local_path{ %w{console_tools ** *.rb} }, &Kernel.fn.require
