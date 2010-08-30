# Keep implicit subject by scoping specs
describe Array do
  it { should respond_to :inject, :tainted?, :hash }
  it { should be_empty }
  
  context "with an element" do
    subject { ['item'] }
    it { should_not be_empty }
  end
end
-------------------0
alias context describe

# `describe` for describing behavior (often a method name)
describe ".class_method" do
end

describe "#instance_method" do
end

# `context` for narrowing the scope.
# Start with "with/when"
-------------------0
describe Order do
  it "should be pending if it hasn't been shipped" do
    # ...
  end
  
  context "when it hasn't been shipped" do
    subject { Factory(:order_to_ship) }
    it { should be_pending }
    its(:status)     { should == 'pending' }
    its(:shipped_on) { should be_nil }
  end
end
-------------------0
# Deep nesting gets confusing, esp. when longer than a screen.
describe Order do
  context "when it hasn't been shipped" do
    context "with other pending orders" do
      context "when its a holiday" do
        # ...

# Defining `let`s up top less complex than nested `before`s

# Minimize lines in a context...
-------------------0
# ... with custom matchers
  it { should be_in_the_slow_queue}

# ... with magic helper methods
# xx factory girl
-------------------0
# ... with shared behaviors

shared_examples_for 'a late order' do
  its(:status)     { should == 'pending' }
  its(:shipped_on) { should be_nil }
  it "should be in the slow queue" do
    # ..
  end
end

context "when its a holiday" do
  it_behaves_like 'a late order'
end
  
-------------------0
# 

