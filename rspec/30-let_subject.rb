let and subject
-------------------0
# Typical way to reuse variables:

describe "Empty Array" do
  before do
    @empty_array = []
  end
  it { @empty_array.should be_empty }
  it { @empty_array.should_not be_nil }
  it { @empty_array.should respond_to(:push, :pop) }
end
-------------------0
describe "Empty Array" do
  let(:empty_array) { [] }
  it { empty_array.should be_empty }
  it { empty_array.should_not be_nil }
  it { empty_array.should respond_to(:push, :pop) }
end
-------------------0
# Generates a method whose return value is memoized
# after the first call.

describe "let is memoized" do
  let(:carl) { puts "hi guys"; 'carl' }
  
  it('') { carl; carl; carl }
  it('') { carl }
end
-------------------0
# Advantage over setting instance variable in `before`:
# - only run when needed
#
# Use as simple factories at the top of specs.

describe "Array" do
  let(:empty_array)       { [] }    
  let(:one_element_array) { ['smap'] }
  let(:huge_array)        { Array.new(1_000, ':)') }
  let(:nil_array)         { [nil, nil, nil] }
  # ...
end
-------------------0
# Advantage over factories:
# - simpler
# - complementary to factories

describe "Pending orders" do
  let(:monday_order)  {  
    Factory.build(:pending_account_order, :week_day => 'monday') 
  }
  let(:tuesday_order) {  
    Factory.build(:pending_account_order, :week_day => 'tuesday') 
  }
  # ...
end
-------------------0
# clearer intent, less noise

class Item < ActiveRecord::Base
  scope :red, where(:colour => 'red')
  
  def self.green
    where(:colour => 'green')
  end
end

dhh.said "Quinn, we considered this, but the def self.scope/end noise for something so common was deemed unhelpful. This also makes the purpose very clear."

# http://m.onkey.org/2010/1/22/active-record-query-interface
-------------------0
# subject - best new rspec feature!
# `should` without a receiver gets delegated to subject
describe "Empty Array" do
  subject { [] }
  it { should be_empty }
  it { should_not be_nil }
  it { should respond_to(:push, :pop) }
end

-------------------0
# Saying the same thing with twice the lines/bytes:
describe "Empty Array" do
  before do
    @empty_array = []
  end
  
  it "should be empty" do
    @empty_array.empty?.should == true
  end

  it "should not be nil" do
    @empty_array.nil?.should == false
  end

  it "should respond to push, pop" do
    @empty_array.respond_to?(:push).should == true
    @empty_array.respond_to?(:pop).should == true
  end
end
-------------------0
# implicit subject

describe 9 do
  it { should == 9 }
end

describe User do
  # subject { User.new }
  
  it { should respond_to :email_count, :add_friend }
  it { should belong_to(:account) }
  it { should have_many(:posts) }
end

-------------------0
# You get a `subject` instance method, like with `let`
describe "Array with 1 item" do
  subject { ['item'] }
  
  it "should be empty after calling pop" do
    subject.pop
    subject.should be_empty
  end
end

# Try and avoid calling `subject`.  Keep things implicit
-------------------0
# Keep implicit subject with `its`
describe "Empty Array" do
  subject { [] }
  
  it { subject.size.should == 0 }

  its(:size) { should == 0 }
end
-------------------0
# `its` can take a string to chain calls
describe "Empty Array" do
  subject { [] }
  its(:size) { should == 0 }
  its('size.zero?') { should be_true }
end