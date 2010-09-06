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

  it 'should remove brackets' do
    'ab ( cd ) ef'.sanitise.should == 'ab cd ef'
  end

  it 'should remove embedded urls' do
    'abc [this article|http://www.thehollandring.com/11stedentocht.shtml] def'.sanitise.should == 'abc this article def'
  end

  it 'should remove italics markup (+)' do
    'a few words +in italics+ are awesome!'.sanitise.should == 'a few words in italics are awesome!'
  end
  
end
