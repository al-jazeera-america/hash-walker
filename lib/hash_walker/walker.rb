module HashWalker
  class Walker
    attr_writer :block


    def hash=(hash)
      @hash = hash.with_indifferent_access
    end

    def walk!
      instance_eval(&@block)
    end

    def method_missing(*args,&block)
      attribute_name = args[0]
      if block_given?
        walker = HashWalker::Walker.new
        walker.block = block
        walker.hash = @hash[attribute_name]
        walker.walk!
      end
      @hash[attribute_name]
    end

  end
end