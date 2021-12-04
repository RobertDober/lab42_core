require_relative '../fn'

class Lab42::Core::StateMachine::Transition

  require_relative 'match'

  attr_reader :next_state, :matcher, :matcher_arity
  def initialize next_state, matcher
    @next_state = next_state
    @matcher    = make_matcher matcher
  end


  def match line, idx, handler
    if matcher_arity == 1
      matcher.(line)
    else
      matcher.(line, idx)
    end.tap do | result |
      return Lab42::Core::StateMachine::Match.new(
        data: result, state: next_state, transition: self, line: line, index: idx, handler: handler
    ) if result
      return nil
    end 
  end

  private

  def make_matcher matcher
    case matcher
    when Regexp
      @matcher_arity = 1
      matcher.fn.match
    when Proc, Method, Lab42::Behavior
      @matcher_arity = matcher.arity
      matcher
    when TrueClass
     ->(*){true} 
    else
      raise ArgumentError, "cannot make a behavoir from #{matcher}"
    end
  end
  
end
# SPDX-License-Identifier: Apache-2.0
