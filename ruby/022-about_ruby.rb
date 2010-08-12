created_by Yukihiro_Matsumoto (aka "Matz")

1.0.released :in => 1996

popularized :by => 'Ruby on Rails', :in => 2005

Smalltalk + Perl

--------------------0
ruby.strengths = {
  :web       => 'rails, sinatra, rack, haml/sass, mustache',
  :testing   => 'rspec, cucumber, webrat, watir, autospec', 
  :scripting => 'capistrano, homebrew, chef, rake'
}

ruby.weakness = [:desktop_apps, :number_crunching, :concurrency]

see 'http://ruby-toolbox.com/'

/ desktop gui wrappers, frameworks Spring, but
    not nearly the focus web has.  not great IDE integration
  hardcore numerical calculations dont want scripting 
    language, or at least use python
  like most languages threads, few tools to deal with state 
    event machine implements reactor, but most libraries
    aren't written to work with it 
/
--------------------0
# Ruby implementations

# official
ruby_18   'c',    :the_standard
ruby_19   'c vm', :faster, :encoding, :functional, :concurrency

# alternate runtimes
jruby     'java', :fast, :popular
ironruby  'c#', :silverlight # microsoft team just disolved :(
macruby   'objective c', :native_objects, :aot_compiled, :iphone?

# others
rubinius  'c++, ruby', :ruby_in_ruby
'maglev, diamondback ruby, ...'
--------------------0
# Ruby implementations compatability - rubyspec

describe "Array#first" do
  
  it "returns the first element" do
    ['a' 'b', 'c'].first.should == 'a'
    [nil].first.should == nil
  end
  
  it "returns nil if self is empty" do
    [].first.should == nil
  end

end
/ test core classes and libraries
  official written standard in the works, required japanese companies
/
