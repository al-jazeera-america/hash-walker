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

    it 'should iterate through arrays' do
      hash = {:stories => [{:a => 1},{:a => 2},{:a => 3}]}
      i=0

      HashWalker.walk(hash) do
        stories do
          i+=1
          a.should == i
        end
      end
    end
  end
end


# TODO symbols vs string keys?