
--------------------0

def secret
  42
end

/ everything is an expression, no declaration\/statements
  not even in python
  unless defined? secret
/

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

