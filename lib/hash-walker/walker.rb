module HashWalker
  class Walker

    def initialize(options)
      @hash_fragment = options[:hash]
      @hash_fragment = @hash_fragment.with_indifferent_access if @hash_fragment.is_a? Hash
      @block = options[:block]
    end

    def walk!
      instance_eval(&@block)
    end

    def value
      @hash_fragment[@attribute_name]
    end

    def next_step_is_array?
      (@hash_fragment.is_a?(Hash) && value.is_a?(Array))
    end

    def get_stepper
      next_step_is_array? ? Stepper::Array.new : Stepper::Hash.new
    end

    def take_one_step
      stepper = get_stepper
      stepper.hash_fragment = value
      stepper.block = @block
      stepper.step!
    end

    def method_missing(*args,&block)
      @attribute_name = args[0]
      @block = block

      take_one_step
    end

  end
end