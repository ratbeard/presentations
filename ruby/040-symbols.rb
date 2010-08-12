--------------------0
# Symbols

start_with :colon

behave_like :basic_string do
  immutable
  used_for "labeling things"
end

--------------------0
record  = { 'first' => 'mike', 'last' => 'frawley'}
record2 = { 'first' => 'chester', 'last' => 'copperpot'}

/ interface db returns a hash.
  makes sense values a strings - upcase them, different per record
  but first and last are just labels, no operations
/
--------------------0
record = { :first => 'mike', :last => 'frawley'}

/ keys are symbols:
    declare intent better
    shorter to type
    different syntax highlighting
    more efficient (next slide)
/
--------------------0
# Symbols are the same object

puts "hi" == "hi"
puts "hi".equal? "hi"
puts :hi.equal? :hi
--------------------0
# Symbols used like global enumerations

text("blah blah", {
  Text::Option::Size  => 15,
  Text::Option::Color => Text::Color::Red
})

text "blah blah", { :size => 15, :color => :red }
