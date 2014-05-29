module HashWalker
  class Walker

    def initialize(options)
      puts '################ initializing'
      @hash = options[:hash]
      @hash = @hash.with_indifferent_access if @hash.is_a? Hash
      @block = options[:block]
      puts "############ @hash=#{@hash.inspect}"
      puts "############ @block=#{@block.inspect}"
    end

    def walk!
      puts "******************** in walk!"
      instance_eval(&@block)
    end

    def method_missing(*args,&block)
      attribute_name = args[0]
      value = @hash[attribute_name] if @hash.is_a? Hash

      puts "in method_missing: @hash=#{@hash.inspect}"
      puts "in method_missing: attribute_name=#{attribute_name}"
      puts "in method_missing: block=#{block.inspect}"
      puts "in method missing: value=#{value.inspect}"


      if value.is_a? Array
        walk_type = 'Array'
      elsif value.is_a? Hash
        walk_type = 'Hash'
      else
        walk_type = 'Primitive'
      end

      puts "in method_missing walk_type is a #{walk_type}"
      puts "in method_missing value is #{value}"

      if walk_type == 'Hash' && block_given?
        puts "taking the next step: as a hash"
        walker = HashWalker::Walker.new(:hash => @hash[attribute_name], :block => block)
        return walker.walk!
      end

      if walk_type == 'Primitive'
        puts "taking the next step: as a primitive"
        return value
      end

      if walk_type == 'Array'
        puts "taking the next step: as a array"
        puts "in array"
        map_ret = value.map do |entry|
          puts "////////////////// walking an array. entry=#{entry.inspect} block=#{block.inspect}"
          walker = HashWalker::Walker.new(:hash => entry, :block => block)
          walker.walk!
        end

        retun map_ret
      end
    end

  end
end