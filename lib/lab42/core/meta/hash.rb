module Lab42
  module Meta
    module Hash extend self
      def hash_replace_rec orig, keys, valblock, limits
        return unlimited_hash_replace_rec orig, keys, valblock unless limits
        limits = ::Hash[ *keys.zip( [limits] * keys.size ).flatten ] unless ::Hash === limits
        limited_hash_replace_rec orig, keys, valblock, limits
      end

      private
      def limited_hash_replace_rec orig, keys, valblock, limits
        orig.inject ::Hash.new do | h, (k, v) |
          h.merge! k => limited_value( keys, k, v, valblock, limits )
        end
      end

      def limited_value keys, k, v, valblock, limits
        if keys.include?( k ) && limits.fetch(k, 1) > 0
          limits[k] and limits[k] -= 1
          Behavior.call_with_arity valblock, [v, k]
        else
          recur_or_value keys, v, valblock, limits
        end
      end

      def recur_or_value keys, v, valblock, limits
        if ::Hash === v
          limited_hash_replace_rec v, keys, valblock, limits
        else
          v
        end
      end

      def unlimited_hash_replace_rec orig, keys, valblock
        orig.inject ::Hash.new do | h, (k, v) |
          h.merge! k => unlimited_value( keys, k, v, valblock )
        end
      end
      def unlimited_value keys, k, v, valblock
        if keys.include? k
          Behavior.call_with_arity valblock, [v, k]
        elsif ::Hash === v
          unlimited_hash_replace_rec v, keys, valblock
        else
          v
        end
      end
    end # module Hash
  end # module Meta
end # module Lab42
# SPDX-License-Identifier: Apache-2.0
