ruby.strengths = {
  :web       => 'rails, sinatra, rack, haml/sass, mustache',
  :testing   => 'rspec, cucumber, webrat, watir, autospec', 
  :scripting => 'capistrano, homebrew, chef, rake'
}
/ ruby on rails what exploded its popularity 2006
  testing is strong part of culture, behavior driven development
    cucumber external dsl.  libraries test web interaction
  designed as OO scripting language.  very easy interact
    with system.  not just reading data files, but things
    like screencast.  basically abstracting over other code
    and 'driving' it.  nice api
/

ruby.weakness = [:desktop_apps, :calculations, :concurrency]

/ desktop gui wrappers, frameworks Spring, but
    not nearly the focus web has.  not great IDE integration
  hardcore numerical calculations dont want scripting 
    language, or at least use python
  like most languages threads, few tools to deal with state 
    event machine implements reactor, but most libraries
    aren't written to work with it 
/

visit 'http://ruby-toolbox.com/'

--------------------0
created_by Yukihiro_Matsumoto (aka "Matz")

1.0.released :in => 1996

popularized :by => 'Ruby on Rails', :in => 2005


--------------------0
# Ruby implementations

# official
ruby_18   'c',    :the_standard
ruby_19   'c vm', :faster, :encoding, :functional, :concurrency

# alternate platforms
jruby     'java', :fast
ironruby  'c#' # microsoft team just disolved :(
macruby   'objective c', :aot_compiled, :native_objects

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
  # ...
end
/ test core classes and libraries
  official written standard in the works, required japanese companies
/
