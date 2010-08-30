require 'rubygems'
require 'spec'

class TreatsExampleGroup < Spec::Example::ExampleGroup
  
  # override
  # if first argument is a symbol, make the subject of this block
  # the result of calling that method.
  # use with `let(:var_name)` 
  def self.describe(*args, &block)
    example_group = super
    example_group.set_subject_from_method_named(args.first) if args.first.is_a?(Symbol)
    example_group
  end
  
  # override
  # Passing a :subjects option will run the example group block 
  # once for each given subject.
  #
  # Can either be an array of values like:
  #   :subjects => [several, subjects, to, run]
  # Or a symbol, which it will call that method and set the description:
  #   :subjects => :odd_numbers
  #
  # Analogous to a FIT table in cucumber.
  # TODO: only generate the docs once.
  def self.run(*args)
    return super unless subjects = options[:subjects]
    
    if subjects.is_a?(Symbol)
      set_description(subjects)
      # need to instantiate to get the actual subjects:
      subjects = new('').send(subjects)
    end
    
    subjects.each do |thing|
      set_subject(thing)
      super
    end
  end  

  def self.set_subject_from_method_named(name)
    set_subject(proc { send name })
  end
  
  def self.set_subject(thing)
    subject_proc = thing.is_a?(Proc) ? thing : proc { thing }
    instance_variable_set :@explicit_subject_block, subject_proc
  end
end
Spec::Example::ExampleGroupFactory.register(:treats, TreatsExampleGroup)
  


describe :type => :treats do
  let(:zero)        { 0 }
  let(:odd_number)  { 5 }
  let(:odd_numbers) { [1, odd_number, 7, 2001] }

  describe :zero do
    it { should be_zero }
  end
  
  describe :subjects => :odd_numbers do
    it { should_not be_zero }
    it { (subject % 2).should == 1}
  end
end


class User
  attr_accessor :name, :age
  def initialize(attributes={})
    attributes.each {|k, v| send "#{k}=", v }
  end
end

describe :type => :treats do
  let(:user)      { User.new }
  let(:old_user)  { User.new(:age => 80) }
  
  it "should allow passing a value to let" do
    carl = old_user(:name => 'carl')
    carl.age.should == 80
    carl.name.should == 80
  end
  
end