# HashWalker

Walk a hash like a hash walker would.

A ruby DSL for walking through hashes. Its the reverse of XmlBuilder. Keys can be symbols or strings, it works either way.

[![Build Status](https://secure.travis-ci.org/galori/hash-walker.png?branch=master)](http://travis-ci.org/galori/hash-walker) [![Code Climate](https://codeclimate.com/github/galori/hash-walker.png)](https://codeclimate.com/github/galori/hash-walker`)


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
4. Some Refactoring(s) ? Some ideas:
    * HashWalker::Walker.new doesn't read quite right.
    * Too much code in method_missing
    * the constructor can take the two arguments (hash and block)
    * other improvements can be had?
## Contributing

Clone and send a pull request, preferably with a test.
Run the tests using `rake`