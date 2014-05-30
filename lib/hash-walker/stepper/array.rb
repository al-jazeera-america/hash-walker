class Stepper::Array < Stepper::Base

  def step!
    @hash_fragment.map do |entry|
      walker = HashWalker::Walker.new(:hash => entry, :block => @block)
      walker.walk!
    end
  end

end