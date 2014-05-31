class Stepper::Base

  attr_accessor :hash_fragment, :block

  def step!
    if @block
      walker = HashWalker::Walker.new(:hash => @hash_fragment, :block => @block)
      walker.walk!
    else
      @hash_fragment
    end
  end

end