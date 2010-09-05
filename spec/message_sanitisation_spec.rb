#!/usr/bin/env ruby
require 'message_sanitisation.rb'

describe 'sanitising of messages' do

  it 'should remove dup weird spaces' do
    " abc\ndef   ghi ".sanitise.should == 'abc def ghi'
  end

  it 'should remove duplicate puncuation' do
    'uni in Chicago.... um.'.sanitise.should == 'uni in Chicago. um.'
  end

end
