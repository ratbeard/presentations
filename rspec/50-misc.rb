require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'spec_helper'

-------------------0
# Rspec 2!

# metagem
http://github.com/rspec/rspec

http://github.com/rspec/rspec-core
http://github.com/rspec/rspec-expectations
http://github.com/rspec/rspec-mocks

-------------------0
# metadata
 
describe "downloading videos", :slow => true do
  it "takes a while" do
    # ....
  end
end

RSpec.configure do |c|
  c.filter_run_excluding :slow => true
end

# http://blog.davidchelimsky.net/2010/06/14/filtering-examples-in-rspec-2/
-------------------0
# Few simple Extensions I've made:
# - symbol to `describe` sets that as the subject
# - :subjects option to describe runs group for each
#   item in collection, like FIT table in cucumber

describe :type => :treats do
  let(:zero)        { 0 }
  let(:odd_numbers) { [1, 13, 7, 2001] }

  describe :zero do
    it { should be_zero }
  end
  
  describe :subjects => :odd_numbers do
    it { should_not be_zero }
    it { (subject % 2).should == 1}
  end
end

# see rspec_treats.rb in the presentation
-------------------0
# I learned alot from

http://pure-rspec-rubynation.heroku.com/
google "rspec presentation"

http://eggsonbread.com/2010/03/28/my-rspec-best-practices-and-tips/
google "rspec best practices"

reading the source!

__END__