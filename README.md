# HashWalker

Walk a hash like a hash walker would.

A ruby DSL for walking through hashes. Its the reverse of XmlBuilder.

## Usage

given this hash:

```ruby
    hash = {
      :host => 'ruby-lang.org',
      :protocol => 'http://',
      :headers => {:user_agent => 'safari'},
      :cache => {:strategy => {:type => 'lazy'}}
    }
```

you would walk it with the following ruby DSL:

```ruby
    HashWalker.walk(hash) do
      cache do
        strategy do
          type.should == 'lazy'
        end
      end
    end
```