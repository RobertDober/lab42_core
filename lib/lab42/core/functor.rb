module Lab42
  class Functor
    attr_reader :args, :block
    private
    def initialize *args, &block
      @args  = args
      @block = block
    end
  end # class Functor
end
