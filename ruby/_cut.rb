# Method with multiple return values
def tag(text)
  str = "<div>#{text}</div>"
  return str, str.length
end

str, length = tag("my blog")
puts "'#{str}' is #{length} characters long"

result = tag("candybar")
puts result.inspect
/ return can return multiple values - coerced to an array
  if you don't have variables to absorb all the elements
    last variable soaks them up in an array
  not too common, kinda cool
/



  tag :class => 'container' do
    tag 'Planets', :tag => 'h1'
    tag :tag => 'ol' do
      tag 'Mercury', :tag => 'li'
      tag 'Venus', :tag => 'li'
    end
  end
  
puts tag "My Vacation", :tag => 'h1', :class => 'loud', :id => 'title1'
/ here we're allowing the user to pass arbitrary key value pairs
    format as html attributes
  one way to handle it, esp. for dsls, is mix these in same hash as
    'official' options.  
  delete official options from hash, returns nil if wasn't present.
  added in print 
/





-----------0
# String literals
str         = "string"
multiline   = " multiline
strings 
rule!"
double_quotes = "interpolate #{str}, esapce \n"
single_quotes = 'no interpolate #{str}, double escape \\n'
strformat     = "%s style %s %0.2f" % ['python', 'interpolation', 1.23456789]

-----------0
# String basics

p plain.length
p 'hello'.count 'l'
p ''.empty?
p 'hello'.include? 'o'
p 'hello'.reverse
p "ho!" * 3

# no autoconversion
p '1'.to_i + 2
p "i have " + 3 + " apples"  # error
p "i have " + 3.to_s + " apples"
p "i have #{3} apples"
/ interpolation calls to_s for us
/
-----------0
# String modification methods
p multiline
p multiline.sub("\n", '')
p multiline.gsub(/\n/, '')

p "  text line\n\t  ".strip
p multiline.split

p "hello".capitalize # upcase, downcase, swapcase

-----------0
# String mutability

# Most methods return a new String
str = "hello"
p str + " there" 
p str

# Some don't:
str << " there"
p str

# But usually its clear (!):
str.gsub!('e', 'X').swapcase!
p str
/ strings are mutable
    not as big a problem might think, most methods return a new string.
    concatting 2 strings doesnt modify original.
    all methods we looked at do this, most have ! alternative
    more efficient, only use if you have full control of the string
/

-------------0
#

--------------------0
# Hello World java

puts "Hello World!"

vs <<Java
class HelloWorldApp {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}
Java



-----------------------0
# Method with variadic arguments and trailing options hash

def tag(*lines)
  if lines.last.is_a?(Hash)
    options = lines.pop
  else
    options = {}
  end
  tag = options[:tag] || 'div'
  lines.map {|text| "<#{tag}>#{text}</#{tag}>"}
end

puts tag "blog post", "my vacation"
puts tag "item 1", "item 2", "item 3", :tag => 'li'

/ take in all args as array and pop off the options hash ourself
/
-----------------------0
# Aside - alternate hash extraction code

options = lines.last.is_a?(Hash) ? lines.pop : {}
          
options = if lines.last.is_a?(Hash)
            lines.pop
          else
            {}
          end


/ trinary operator, probably how you'd see it
  second way is kinda weird looking, some people like it
  important highlights again everything is an expression
    that returns its last executed expression
/
-----------------------0
# Method with options hash including arbitrary attributes

def tag(text, options={})
  puts "options before processing: #{options.inspect}"
  tag = options.delete(:tag) || 'div'
  puts "options after  processing: #{options.inspect}"
  attrs = options.map {|(key, value)| "#{key}='#{value}'" }.join(' ')
  
  "<#{tag} #{attrs}>#{text}</#{tag}>"
end

puts tag "My Vacation", :tag => 'h1', :id => 'title1'
/ here we're allowing the user to pass arbitrary key value pairs
    format as html attributes
  one way to handle it, esp. for dsls, is mix these in same hash as
    'official' options.  
  delete official options from hash, returns nil if wasn't present.
  added in print 
/


--------------------0
# Symbols implemented as global enumeration

puts Symbol.all_symbols.length
:huh?
puts Symbol.all_symbols.length



--------------------0
# Example: printing out instance variables
obj = Object.new

obj.instance_variable_set("@dynamic", true)
obj.instance_variable_set("@father", 'smalltalk')
obj.instance_variable_set("@creator", 'matz')

obj.instance_variables.each do |name|
  value = obj.instance_variable_get(name)
  puts "obj's #{name} is: #{value}"
end
/ generic loop through state.  
  image saving it in a hash, storing as json in a db
/
--------------------0
# Module as state-less method holders

puts Geometry.respond_to? 'area'
Geometry.new.area(5)

module Geometry
  module_function 'area'
end

Geometry.area(10)
/ can't call area on Geometry 
  can't instantiate Geometry, only classes
  declare it as a module_function
  not too common, this bad example, Math.sqrt
/

--------------------0
module VariableSerializer
  def serialized_variables
    result = {}
    instance_variables.each do |name|
      result[name] = instance_variable_get(name)
    end
    result
  end
end

module VariableRandomizer
  def generate_variables(count=3, name='@a')
    count.times do
      instance_variable_set(name, rand(100))
      name.next!
    end
  end
end

obj = Object.new
obj.extend(VariableSerializer)
obj.extend(VariableRandomizer)

obj.generate_variables(5)
puts obj.serialized_variables

--------------------0
# Case statement

aka 'switch statement'
highlights 'rubys design'

--------------------0

def greet(thing)
  case thing
  when 'hi'
    'hi back'
  when 'hello', 'hiya', 42
    'YO!'
  when /\?$/
    'Great, you?'
  when 1999..2001
    'y2k'
  when Fixnum
    thing * 2
  else
    thing
  end
end

--------------------0

case
when age < 12
  "lego"
when age >= 12 && male?
  "halo"
else 
  'ball'
end

if age < 12
  "lego"
elsif age >= 12 && male?
  "halo"
else 
  'ball'
end

--------------------0

"str"      === "str"
String     === "str"
/tr/       === "str"
("a".."z") === "g"

--------------------0

'
- Familiar but improved semantics.
- Flexible syntax.
- Underlying matching mechanism is 
  a method (===).
- Expressive literals (RegExp, Ranges).
'


--------------------0
# Ruby basic program 4 verbose edition
inventory = Hash.new()
inventory['ipod'] = 12
inventory['baseball'] = 50

while true do
  puts("Inventory: " + inventory.inspect() + ". Buy?")
  input = gets().chomp()
  if input == 'q'
    break
  end
  if inventory.include?(input)
    inventory[input] = inventory[input] - 1
  end
end

/ ruby great - many small things
  even at low procedural level, take alot of noise out of your code
/
