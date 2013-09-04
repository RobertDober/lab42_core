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
end # class Hash
