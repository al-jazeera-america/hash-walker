module HashWalker

  def self.walk(hash,&blocky)
    walker = HashWalker::Walker.new(:hash => hash, :block => blocky)
    walker.walk!
  end

end