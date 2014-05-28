module HashWalker

  def self.walk(hash,&block)
    walker = HashWalker::Walker.new
    walker.hash = hash
    walker.block = block
    walker.walk!
  end

end