matchers
-------------------0
# bad
describe "Empty Array" do
  it "should be empty" do
    [].empty?.should == true
  end
end

# Not much benifet from rspec.
-------------------0
# better
describe "Empty Array" do
  it "should be empty" do
    [].should be_empty
  end
end

# We are giving rspec more information
-------------------0
# Rspec can use that information to build a better error message:

describe "Empty Array" do
  it "should be empty" do
    [1].empty?.should == true
  end

  it "should be empty" do
    [1].should be_empty
  end
end
-------------------0
# Rspec can use that information to build a spec doc
describe "Empty Array" do
  it "should be empty" do
    [].should be_empty
  end
  
  it { [].should be_empty }
end
-------------------0
# Any method ending with `?` can auto-generate a matcher.
# Remove the `?` and prefix with `be_`, `be_a_`, or `be_an_`

describe "Empty Array" do
  it { [].should_not be_nil }

  it do
    a = stub(:neat? => true)
    a.should be_neat
  end
end