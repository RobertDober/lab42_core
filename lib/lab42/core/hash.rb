require_relative 'meta'
class Hash

  def fetch! key, *defaults, &defblk
    default_present = !(defaults.empty? && defblk.nil?)
    return fetch key unless default_present
    fetch key do
      self[ key ] = defblk ? defblk.() : defaults.first
    end
  end
  alias_method :fetch_or_set, :fetch!
  
  def replace_rec *keys, limit: nil, limits: nil, &valblock
    raise ArgumentError, "must not pass in limit: and limits: keyword parameters" if limit && limits
    return Lab42::Meta::Hash.hash_replace_rec self, keys, valblock, limit || limits
  end

  def only *args
    args.inject Hash.new do | r, k |
      if has_key? k
        r.merge k => self[k]
      else
        r
      end
    end
  end

  def reject_values *behavior, &beh
    beh = Lab42::Meta::Behavior.behavior *behavior, &beh
    reject{ |_, v| beh.(v) }
  end

  def select_values *behavior, &beh
    beh = Lab42::Meta::Behavior.behavior *behavior, &beh
    select{ |_, v| beh.(v) }
  end

  def with_present key, default: nil
    if has_key? key
      yield fetch(key), self
    else
      default
    end
  end

  def without *keys
    inject Hash.new do | r, (k,v) |
      if keys.include? k
        r
      else
        r.merge k => v
      end
    end
  end
end # class Hash
# SPDX-License-Identifier: Apache-2.0
