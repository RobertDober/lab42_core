require 'forwarder/evaller'

module Forwarder
  class Arguments
    attr_reader :args, :message, :target

    def all?
      !args? && !lambda? && @__all__
    end

    def after
      @after ||= @params[:after]
    end

    def after?
      after
    end

    def aop?
      @__aop__ ||= !aop_values.empty?
    end

    def args?
      !!args
    end

    def before
      @before ||= @params[:before] || @params[:before_with_block]
    end

    def before?
      before
    end

    def before_with_block?
      !!@params[:before_with_block]
    end


    def chain?
      @params[ :to_chain ]
    end

    def complete_args *args
      (self.args || []) + args
    end

    def custom_target?
      @params[:to_object]
    end

#     def delegatable?
#       !aop? && !custom_target? && !all? && !chain? && !args && !lambda?
#     end

    def evaluable?
      !lambda? &&
        !aop? &&
        ( !args || args.all?{|a| Evaller.evaluable? a } ) &&
        ( !custom_target? || Evaller.evaluable?( custom_target? ) )
    end

    def lambda default=nil
      lambda? || default
    end

    def lambda?
      @lambda
    end

    def must_not_compile?
      lambda? || aop? || custom_target?
    end

    # This is always nil unless we are a custom_target, in which case
    # default is returned if target is :self, else target is returned
    def object_target default
      return unless custom_target?
      target == :self ? default : target
    end

    def serialized_params
      Evaller.serialize args
    end
      
    def to_hash?
      @__to_hash__ ||= @params[ :to_hash ]
    end

    def translation alternative=nil, &blk
      @params[ :as ].tap do | tltion |
        break alternative unless tltion
        break tltion unless blk
        blk.( tltion ) 
      end
    end

    private
    def aop_values
      @__aop_values__ ||= @params.values_at( :after, :before, :before_with_block ).compact
    end

    def check_for_incompatibilities!
      raise ArgumentError, "cannot provide translations for forward_all" if @__all__ && translation
      raise ArgumentError, "cannot provide arguments for forward_all" if @__all__ && args?
    end

    def initialize *args, &blk
      @message = args.shift
      raise ArgumentError, "need one message and a hash of kwd params, plus an optional block" unless args.size == 1 && args.first.is_a?( Hash )
      @params = args.first
      set_message
      set_target
      set_args blk
      check_for_incompatibilities!
      translate_to_hash
    end

    def set_args blk
      set_lambda blk
      hw = @params.has_key? :with
      ha = @params.has_key? :with_ary
      raise ArgumentError, "cannot use :with and :with_ary parameter" if hw && ha
      unless to_hash?
        set_args_normal if hw
        set_args_ary if ha
      end
    end

    def set_args_ary
      @args = [ @params[:with_ary] ]
      raise ArgumentError, ":with_ary needs an array parameter" unless Array === @args.first
    end

    def set_args_normal
      case arg = @params[:with]
      when Array
        @args = arg.dup rescue arg
      else
        @args = [ (arg.dup rescue arg) ]
      end
    end

    def set_message
      case @message
      when Array
        @__all__ = true
      end
    end

    def set_lambda blk

      if use_block?
        @after  = blk if @params[:after] == :use_block
        @before = blk if @params[:before] == :use_block || @params[:before_with_block] == :use_block
        @lambda = @params[:with_block]
      else
        raise ArgumentError, "cannot use :with_block and a block" if
          @params[:with_block] && blk

        @lambda = @params.fetch :with_block, blk
      end
    end

    def set_target
      [:to, :to_chain, :to_object, :to_hash].each do | tgt_kwd |
        tgt = @params[ tgt_kwd ]
        next unless tgt

        raise ArgumentError, "more than one target specified." if @target
        @target = tgt 
      end
      raise ArgumentError, "no target specified." unless @target
    end

    def translate_to_hash
      return unless @params[:to_hash]
      raise ArgumentError, "cannot provide arguments for to_hash:" if @params.has_key?( :with ) || @params.has_key?( :with_ary )
    end
    def use_block?
      aop_values.include?( :use_block )
    end
  end # class Arguments
end # module Forwarder
