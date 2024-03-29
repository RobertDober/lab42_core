module Enumerable

  def find_with_value default_value=nil, &blk
    each do | val |
      val_prime = blk.(val)
      return val_prime if val_prime
    end
    default_value
  end

  def grep2 expr
    partition{ |ele| expr === ele }
  end

  
  def to_proc
    this = self
    yielder = to_enum.lazy
    -> do
      yielder.next
    end
      .extend( Module.new do
        define_method :reset! do
          yielder = this.to_enum.lazy
        end
      end)
  end
end

class Enumerator::Lazy
  def grep2 expr
    [ select{ |x| expr === x }, reject{ |x| expr === x } ]
  end

  # def to_proc
  #   this = self
  #   yielder = to_enum.lazy
  #   -> do
  #     yielder.next
  #   end
  #     .extend( Module.new do
  #       define_method :reset! do
  #         yielder = this.to_enum.lazy
  #       end
  #     end)
  # end
end
# SPDX-License-Identifier: Apache-2.0
