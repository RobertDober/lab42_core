require 'forwarder'
# require 'lab42/core/open_object/transformations'

class OpenObject
  include Enumerable

  # include Lab42::Core::OpenObject::Transformations

  extend Forwarder
  forward_all :[], :keys, :length, :size, :values, to: :@data

  def == other
    self.class === other && to_hash == other.to_hash
  end
  def each &blk
    @data.each do | k, v |
      blk.( self.class.new k => v )
    end
  end

  def to_hash
    @data.clone
  end
  def update **params
    new_params = @data.merge params
    self.class.new( **new_params )
  end
  alias_method :merge, :update


  private
  def initialize( **params )
    @data = params
    params.each do |k, v|
      class << self; self end.module_eval do
        define_method(k){v}
      end
    end
  end

  class << self
    def inherited *args, **kwds, &blk
      raise RuntimeError, "I prefer delegation to inheritance, if you do not, MP me"
    end

    def merging *args
      new **(
        args.inject Hash.new do |r, arg|
          r.merge arg.to_hash
        end
      )
    end
  end
end # class OpenObject

class Hash
  def to_open_object
    OpenObject.new **self
  end
end
# SPDX-License-Identifier: Apache-2.0
