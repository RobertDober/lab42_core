module Lab42
  class Functor
    module IsAProc
      def to_proc
        -> *a, &b do
          call(*a, &b)
        end
      end
    end
    include IsAProc
  end # class Functor
end # module Lab42
