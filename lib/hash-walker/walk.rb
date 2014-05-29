module HashWalker

  def self.walk(hash,&blocky)

    def blocky.to_s
      "[block] outer block"
    end

    puts "in outer thing. blocky=#{blocky.inspect}"
    walker = HashWalker::Walker.new(:hash => hash, :block => blocky)
    walker.walk!
  end

end