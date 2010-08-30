builtin matchers
-------------------0
describe "eq" do
  it "matches when actual == expected" do
    3.should == 1 + 2
    3.should eq(1 + 2)
  end
end
-------------------0
describe "be_a" do
  it { "str".should be_a(String) }
end
-------------------0
describe "array.should =~ other_array" do
  it "passes if target contains all items out of order" do
    [1,3,2].should =~ [1,2,3]
  end
  
  it { [1,2].should =~ [2,3] }
end
-------------------0
describe 'have' do
  before do
    @shirt = stub(:colors => ['red', 'black'])
  end
  
  it "should have 2 colors" do
    @shirt.colors.length.should == 2
  end
  
  it { @shirt.should have(2).colors }
  it { @shirt.should have_at_least(2).colors }
  it { @shirt.should have_at_most(2).colors }
end
-------------------0
describe "raise_error" do
  it do
    lambda { 5 / 0 }.should raise_error
  end
  
  it do
    expect { 5 / 0 }.to raise_error
  end
end
-------------------0
# Extends the submitted block with aliases to and to_not
# for should and should_not. 
def expect(&block)
  block.extend BlockAliases
end

module BlockAliases
  alias_method :to,     :should
  alias_method :to_not, :should_not
end
-------------------0
describe "division by 0" do
  example do
    expect { 5 / 0 }.to raise_error
    expect { 5 / 0 }.to raise_error(ZeroDivisionError)
    expect { 5 / 0 }.to raise_error('divided by 0')
    expect { 5 / 0 }.to raise_error(/divided.*0/)
    expect { 5 / 0 }.to raise_error(ZeroDivisionError, /divided/)
  end
end
-------------------0
describe "change" do
  it do
    ary = [1, 2, 3]
    expect { ary.pop }.to change(ary, :size).by(-1)
  end
  
  it do
    ary = [1, 2, 3]
    expect { ary.pop }.to change(ary, :size).from(3).to(2)
  end
end
-------------------0
describe 9 do
  it "should be a multiple of 3" do
    (9 % 3).should == 0
  end
  
  it { 9.should be_a_multiple_of(3) }
end

Spec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end
end

-------------------0
Spec::Matchers.define :be_a_multiple_of do |expected|
  match do |actual|
    actual % expected == 0
  end

  description do
    "be a precise multiple of #{expected}"
  end
  
  failure_message_for_should # ...
  failure_message_for_should_not # ...
end

# http://wiki.github.com/dchelimsky/rspec/custom-matchers
-------------------0
# shoulda rails matchers

describe User, "with shoulda macros" do
  it { should belong_to(:account) }
  it { should have_many(:posts) }
  it { should validate_presence_of(:email) }
  it { should allow_value("test@example.com").for(:email) }
  it { should_not allow_value("test").for(:email) }
end

# http://robots.thoughtbot.com/post/159805987/speculating-with-shoulda