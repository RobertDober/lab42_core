class Integer
  class << self
    def cksum of_number
      (of_number % 9).succ
    end
  end # class <<
end # class Integer
