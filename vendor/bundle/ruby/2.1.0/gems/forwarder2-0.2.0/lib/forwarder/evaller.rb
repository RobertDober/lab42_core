module Forwarder
  module Evaller extend self

    NotSerializable = Class.new RuntimeError

    def evaluable? an_object, cache={}
      !!_serialize_one( an_object, cache )
    rescue NotSerializable
      false
    end

    def serialize args
      return "" if args.nil? || args.empty?
      serialize_without_arg_suffix( args ).join(", ") + ", "
    rescue NotSerializable
      nil
    end

    def serialize_without_arg_suffix args, cache={}
      args.map{ | arg |
        _serialize_one arg, cache
      }
    end

    private
    def _serialize_hash hsh, cache
      hsh.inject [] do | r, (k, v) |
        k = _serialize_one k, cache
        v = _serialize_one v, cache
        r << "#{k} => #{v}"
      end.join( ", ")
    end

    def _serialize_one arg, cache
      case arg
      when String
        "'" + arg + "'"
      when Symbol, Fixnum, NilClass, FalseClass, TrueClass
        arg.inspect
      else
        _serialize_object arg, cache
      end
    end

    def _serialize_object arg, cache
      oid = arg.object_id
      raise NotSerializable if cache[oid]
      cache[oid]=true
      case arg
      when Array
        ["[ ", serialize_without_arg_suffix( arg, cache ).join(", "), " ]"].join
      when Hash
        [ "{ ", _serialize_hash( arg, cache ), " }" ].join
      else
        raise NotSerializable
      end
    end
  end # module Evaller
end # module Forwarder
