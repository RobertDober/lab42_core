require_relative 'behavior'

module Lab42
  # Thank youn my dear Proxy, for sending me all the information
  # I, the clever guy, who is having all the fun, will make best
  # use of it by being an extremly, yes I said *extremly* clever
  # callable object representing the methods or instance methods
  # represented by the calls to `Object#fn` or `Module#fm`. 
  # Did I tell you yet? It is sooooo out not be functional...
  class UnboundBehavior
    attr_reader :args, :block, :method

    def call *a, &b
      m = method.bind a.first
      m.( *(a.drop(1) + args), &(b||block) )
    end

    def to_proc
      -> *a, &b do
        m = method.bind a.first
        m.( *(a.drop(1) + args), &(b||block) )
      end
    end

    # Rebinding:
    # We still apply our LIFO policy! So much for the proverbial
    # "The early bird catches the worm"? Anyway, what would I do
    # with a worm??? (Mescal maybe?)
    def _ *a, &b
      self.class.new @klass, method, *(a + args), &(b||block)
    end

    private
    def initialize klass, method, *args, &block
      @klass  = klass
      @method = method
      @args   = args
      @block  = block
    end

  end # class Behavior
end # module Lab42
