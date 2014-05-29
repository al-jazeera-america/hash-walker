module HashWalker

  def self.walk(hash,&block)
    walker = HashWalker::Walker.new(:hash => hash, :block => block)
    walker.walk!
  end

end