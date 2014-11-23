class Hash
  def only *args
    args.inject Hash.new do | r, k |
      if has_key? k
        r.merge k => self[k]
      else
        r
      end
    end
  end

  def with_present key, default: nil
    if has_key? key
      yield fetch(key), self
    else
      default
    end
  end
end # class Hash
