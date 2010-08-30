# Keep implicit subject by scoping specs
describe Array do
  it { should respond_to :inject, :tainted?, :hash }

  context "with no elements" do
    it { should be_empty}
  end
  
  context "with one element" do
    subject { ['item'] }
    it { should_not be_empty }
  end
end
-------------------0
alias context describe

# `describe` for describing behavior (often a method name)
# `context` for narrowing the scope. Start with "with/when"
#     e.g. "when user has logged out"
#          "with 2 arguments"

-------------------0
# poor organization

describe Order do
  it "should have pending status if it hasn't been shipped" do
    order = Factory(:order_to_ship)
    order.should be_pending
    order.status.should == 'pending'
    order.shipped_on.should be_nil
  end
  
  it "should have sent status if it has been shipped " do
    #  ...
  end
end
-------------------0
# Organized behavior into groups
# More explicit specs - 1 assertion per spec
# Same amount of lines!

describe Order do  
  context "when it hasn't been shipped" do
    subject { Factory(:order_to_ship) }
    it { should be_pending }
    its(:status)     { should == 'pending' }
    its(:shipped_on) { should be_nil }
  end
end
-------------------0
# Deep nesting gets confusing, BAD when longer than a screen.
describe Order do
  context "when it hasn't been shipped" do
    context "with other orders in the queue" do
      context "when its a holiday" do
        # ...


# Using `let` less confusing than nested `before`s
# Minimize lines ...
-------------------0
# Minimize lines with custom matchers
  it { should be_in_the_slow_queue }
-------------------0
# Minimize lines with shared behaviors

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

# Used by plugin/adapter testing libraries
-------------------0
# Minimize lines by making setup helper methods

describe "factorygirl definition loading" do
  context "with a factories file under #{dir}" do
    in_directory_with_files File.join(dir, 'factories.rb')
    it_should_behave_like "finds definitions"
    it { should require_definitions_from("#{dir}/factories.rb") }
  end

  context "with a factories file under #{dir}/factories" do
    in_directory_with_files File.join(dir, 'factories', 'post_factory.rb')
    it_should_behave_like "finds definitions"
    it { should require_definitions_from("#{dir}/factories/post_factory.rb") }
  end
end