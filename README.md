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

you would traverse it with the following ruby DSL:

```ruby
    HashWalker.walk(hash) do
      cache do
        strategy do
          puts type
        end
      end
    end
```

### Arrays

given this hash:

```ruby
    hash = { stories: [
        {:title => 'a', :url => 'http://some-url/a'},
        {:title => 'b', :url => 'http://some-url/b'},
        {:title => 'c', :url => 'http://some-url/c'}
    ]}
```

you would traverse it with the following ruby DSL:

```ruby
    HashWalker.walk(hash) do
      stories do
        puts title
        puts url
      end
    end
```

### Non existant keys

Non existant keys are skipped gracefully

```ruby
    hash = { :set1 => { :a => 1, :b => 1 }}
```

you would traverse it with the following ruby DSL:

```ruby
    HashWalker.walk(hash) do
      set1 do
        puts a
      end

      set2 do
        puts a
      end
    end
```

you would get this output:

```ruby
  1
```


## Contributing

Clone and send a pull request, preferably with a test.
Run the tests using `rake`

* TODO: map vs. join? at least test it
* TODO: ability to reach out to parent (parent. something?)
* TODO: ability to reach out to siblings?
* TODO: Top level arrays/ (are they valid JSON and valid HAshes?)
* TODO: accept JSON or HASH or HTTParty response
* TODO: HTTParty adapter.   httparty_response.walk()
* TODO: Adapter for other libaries? VCR? Mechanize? REGEXP? Nokogiri?
* TODO: return a value from the entire outer bloc
* TODO: test more stuff at the top level / outer block level
* TODO: access to key names
* TODO: generate the DSL based on an existing hash (like a VCR cassette?)
* TODO: option to raise an error or not raise an error if referencing a non-existant key
* TODO: don't look for Hash's and Array's, look for objects that act like Hash's and act like Arrays. (objects and enumarbles?)