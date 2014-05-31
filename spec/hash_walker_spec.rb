require 'spec_helper'

describe HashWalker do
  it 'should have a version number' do
    HashWalker::VERSION.should_not be_nil
  end

  describe 'the DSL' do
    let(:hash) {
      hash = {
          :host => 'ruby-lang.org',
          :protocol => 'http://',
          :headers => {:user_agent => 'safari'},
          :cache => {:strategy => {:type => 'lazy'}}
      }
    }
    it 'access to top level attributes of the hash' do
      HashWalker.walk(hash) do
        host.should == 'ruby-lang.org'
      end
    end

    it 'allow walking into a key' do
      expect {
        HashWalker.walk(hash) do
          headers do
            raise 'this line was executed!'
          end
        end
      }.to raise_error('this line was executed!')
    end

    it 'should allow walking into a key and then provide access to its attributes' do
      HashWalker.walk(hash) do
        headers do
          user_agent.should == 'safari'
        end
      end
    end

    it 'should allow walking down two levels of keys' do
      expect {
        HashWalker.walk(hash) do
          cache do
            strategy do
              raise "We're down two levels!"
            end
          end
        end
      }.to raise_error("We're down two levels!")
    end

    it 'should allow walking down two levels of keys and reading attributes' do
      HashWalker.walk(hash) do
        cache do
          strategy do
            type.should == 'lazy'
          end
        end
      end
    end

    it 'should work with strings as keys' do
      hash = {'string_key' => 'String Value'}
      HashWalker.walk(hash) do
        string_key.should == 'String Value'
      end
    end

    it 'should work with strings as symbols' do
      hash = {:string_key => 'String Value'}
      HashWalker.walk(hash) do
        string_key.should == 'String Value'
      end
    end

    it 'should do something with a block on a value' do
      hash = {:a => 'b'}
      dummy = double('dummy')
      dummy.should_receive(:block_was_run)
      HashWalker.walk(hash) do
        a do
          dummy.block_was_run
        end
      end
    end

    it 'should iterate through arrays' do
      hash = {:stories => [{:a => 1},{:a => 2},{:a => 3}]}
      dummy = double('dummy')
      dummy.should_receive(:set_a_value).with(1).ordered
      dummy.should_receive(:set_a_value).with(2).ordered
      dummy.should_receive(:set_a_value).with(3).ordered

      HashWalker.walk(hash) do
        stories do
          dummy.set_a_value(a)
        end
      end
    end

    it 'should iterate through arrays and return an array of the results like .map' do
      hash = {:stories => [{:a => 1},{:a => 2},{:a => 3}]}
      HashWalker.walk(hash) do
        stories do
          a
        end.should == [1,2,3]
      end
    end

    it 'should skip missing keys or attributes without raising an error' do
      hash = {:stories => 'something'}
      expect {
        HashWalker.walk(hash) do
          stories do
            some_non_existant_key
          end
        end
      }.not_to raise_error
    end
  end
end


# TODO: map vs. join? at least test it
# TODO: ability to reach out to parent (parent. something?)
# TODO: ability to reach out to siblings?
# TODO: Top level arrays/ (are they valid JSON and valid HAshes?)
# TODO: accept JSON or HASH or HTTParty response
# TODO: HTTParty adapter.   httparty_response.walk()
# TODO: Adapter for other libaries? VCR? Mechanize? REGEXP? Nokogiri?
# TODO: return a value from the entire outer bloc
# TODO: test more stuff at the top level / outer block level
# TODO: access to key names
# TODO: generate the DSL based on an existing hash (like a VCR cassette?)
# TODO: option to raise an error or not raise an error if referencing a non-existant key
# TODO: don't look for Hash's and Array's, look for objects that act like Hash's and act like Arrays. (objects and enumarbles?)