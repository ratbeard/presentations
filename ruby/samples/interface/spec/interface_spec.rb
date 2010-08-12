require 'interface'

class EnhancedExampleGroup < Spec::Example::ExampleGroup
  
  # if first argument to describe is a symbol, set the explicit subject of this block
  # to the variable declared with the same name using `let(:var_name)` 
  def self.describe(*args, &block)
    example_group = super
    example_group.set_declared_variable_as_subject(args.first) if args.first.is_a? Symbol
    example_group
  end
  
  def self.set_explicit_subject(thing)
    instance_variable_set :@explicit_subject_block, thing.is_a?(Proc) ? thing : proc { thing }
  end
  
  def self.set_declared_variable_as_subject(name)
    if new('blah').respond_to?(name) 
      set_explicit_subject(proc { send name } )
    end
    # set_explicit_subject(new('blah').send(name))
  end
  
  
  # track declared variable names
  # doesn't work - need an 'inheritable list'.  whats a better alternative to: new('blah').respond_to?(new) 
  # def self.let(name)
  #   (@declared_variables ||= []) << name
  #   super
  # end
  
  # aditional arguments beyond the attribute name are treated as arguments to forward 
  # when calling that attribute method.
  # Another option would be to treat them as recursive attributes to call:
  #   its(:children, :children, :name) { should == 'grandkid' }
  # I don't like the implementation of its - its simple, but generates extra contexts in the docstring,
  # and screws up the it's line numbers.
  def self.its(attribute, *args, &block)
    describe(attribute) do
      define_method(:subject) { super().send(attribute, *args) }
      it(&block)
    end
  end
  
  # if :subjects => :declared_variable_name_that_returns_an_array 
  # is given to a describe, run all specs in the example group with each
  # member as the subject.  
  # should only generate the docs once :/
  # analogous to given a table of values to run in cucumber
  def self.run(*args)
    if options[:subjects]
      subjects = new('blah').send options[:subjects]  # expecting an array of subjects
      subjects.each do |thing|
        set_explicit_subject(thing)
        super
      end
    else
      super
    end
  end  
end
Spec::Example::ExampleGroupFactory.register(:enhanced, EnhancedExampleGroup)

describe :type => :enhanced do
  let(:zero)        { 0 }
  let(:odd_number)  { 5 }
  let(:odd_numbers) { [1, odd_number, 7, 2001] }

  describe :zero do
    it { should == 0 }
    it { should be_zero }
  end
  
  describe 'odd numbers', :subjects => :odd_numbers do
    it { should_not be_zero }
    it { (subject % 2).should == 1}
    its(:%, 2) { should == 1 }
  end
end

# 
# describe Interface do
#   
#   
#   Interface :rewindable do
#     method :rewind
#   end
#   
#   Interface :playable do
#     method :play
#     method :pause
#   end
#   
#   
#   class Cassette
#     include Interface    
#     implements :rewindable, :playable
#     
#     def rewind; end
#     def play; end
#     def pause; end
#   end
# 
#   class BrokenCassette
#     include Interface
#     implements :rewindable, :playable
#   
#     def rewind; end
#     self
#   end
#   
#   let(:incomplete_implementation) do
#     class Broken
#       include Interface
#       implements :rewindable, :playable
#     
#       def rewind; end
#       self
#     end
#   end
# 
#   describe ".implements" do
#     context "with arguments" do
#     end
#     
#     context "without arguments" do
#       subject { BrokenCassette.implements }
#       it { should be_kind_of Interface::Manager }
#     end
#   end
#   
#   
#   describe ".implements?" do
#     it "" do
#       BrokenCassette.implements?(:rewindable).should be_true
#     end
#     it "" do
#       BrokenCassette.implements?(:playable).should be_nil
#     end
#     it "" do
#       BrokenCassette.implements?(:fizz).should be_false
#     end
#   end
#   
#   describe ".implements!" do
#     context "with a class that implements all interfaces" do
#       it { 
#         subject
#         Cassette.implements!.should be_true }
#     end
#     context :incomplete_implementation do
#       # it { expect { subject.implements! }.should raise_error(/playable/) }
#     end
#   end
#   
#   describe "included in a class" do    
#     subject { Cassette }
#     it { should respond_to :implements }
#   end
#   
# end
