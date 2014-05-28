# HashWalker

Walk a hash like a hash walker would.

A ruby DSL for walking through hashes. Its the reverse of XmlBuilder. Keys can be symbols or strings, it works either way.

## Usage

given this hash:

```ruby
    hash = {
      :host => 'ruby-lang.org',
      :protocol => 'http://',
      :headers => {:user_agent => 'safari'},
      :cache => {'strategy' => {'type' => 'lazy'}}
    }
```

you would walk it with the following ruby DSL:

```ruby
    HashWalker.walk(hash) do
      cache do
        strategy do
          puts type
        end
      end
    end
```

You will get the following output:

```
lazy
```

Note: This is in development and it is not feature complete.

TODO:

1. Iterate through arrays
2. Decide how to handle non existant keys
3. Decide if to allow assignment and how to handle (or is this read only?)