# No Namespaces Here

require_relative '../core'
require_relative 'fn'
def B *a, &b
  Lab42::Meta::Behavior *a, &b
end
Dir.glob File.expand_local_path{ %w{console_tools ** *.rb} }, &Kernel.fn.require
