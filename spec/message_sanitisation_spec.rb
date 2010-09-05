#!/usr/bin/env ruby
require 'message_sanitisation.rb'

describe 'sanitising of messages' do

  it 'should include removal of dup weird spaces' do
    " abc\ndef   ghi ".sanitise.should == 'abc def ghi'
  end

  it 'should remove duplicate puncuation' do
    'uni in Chicago.... um.'.sanitise.should == 'uni in Chicago. um.'
  end

  it 'should remove bare urls' do
    'abc Interesting powerpoint: http://www.ukaachen.de/go/show?ID=4610696&DV=0&COMP=download&NAVID=4562276&NAVDV=0 def'.sanitise.
      should == 'abc Interesting powerpoint: def'
  end

end