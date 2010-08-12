--------------------0

begin object oriented programming 
end

--------------------0

obj = Object.new

"object individuation"

/ focus on objects, not classes.
  not 'class oriented program'
  classes important, main design tool
    unique ability to create objects
    in ruby, classes are just objects
    once created, objects can change not only state but behavior
    aquire new methods\/behavior beyond their class
  objects 
/
--------------------0
# Method reflection

obj = Object.new

obj.methods
obj.public_methods
obj.protected_methods
obj.private_methods
obj.singleton_methods
obj.respond_to? :inspect


/ new object has many methods (more especially in irb)
  methods == public_methods
  false hide inherited methods
/

--------------------0
# Object Class reflection
obj = Object.new

obj.class
obj.class.ancestors
obj.class.superclass
obj.is_a?(Object)

Object.instance_methods
obj.class.instance_methods

--------------------0
# State is stored in instance variables

obj = Object.new
obj.instance_variable_defined? "@age"
obj.instance_variable_set("@age", 12)
obj.instance_variable_get("@age")
obj.instance_variables

/ start with a @.  like _ convention, enforced by language
  private to an object, reflection methods to query, get, set
/
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
# Object Individuation!

str = "party"

def str.kaboom!
  self + "!!!"
end

puts str.kaboom!
puts "bomb".kaboom!

puts str.singleton_methods
/ special form of def - not only method, but the receiver
  try it on another string, but
/
--------------------0
' -----------
  |         |
  | String  |    class
  |         | 
  -----------
      |
      |
  -----------
  |         |
  | "party" |    object
  |         | 
  ----------- '
--------------------0
' -----------
  |         |
  | String  |   class
  |         | 
  -----------
      |
  - - - - - -
  | o   o   |
  |   ()    |   singleton
  |  \__/   |    class
  - - - - - -
      |
  -----------
  |         |
  | "party" |   object
  |         | 
  ----------- '
/ special class just for that object.  
  nothing to do with singleton design pattern
    aka eigen, metaclass, ghost class
  ruby semantics every object has, only created on access.
  anonymous, doesn't show up un that objects ancestors
    hard to get at.  special syntax to 'open' it up...
/
--------------------0
# Cryptic syntax to change scope to a singleton class

str = 'party'

class << str
  def kaboom!
    self + "!!!"
  end
  
  def pool?
    true
  end
end

str.kaboom! if str.pool?

/ changes scope to `str`
    any methods we define will be on it
  syntax weird, some don't like it.
  in general, prefer the previous form explicit
    receiver. this form is useful since we changing
    scope, we can access private methods of str's class
/
--------------------0
# Next up: Modules
module Geometry
  PI = 3.14159265358979
  
  def area(radius)
    PI * (radius ** 2)
  end
end

/ more generic than classes
    contain methods and constants, but can't be instantiated
    Class.superclass == Module
  ruby constants start with capital
    class and module names, actual constants
    camel case, all caps
/
--------------------0
# Modules as namespaces
# Constant Dereference with ::
# Reopening modules

puts Geometry::PI

module Geometry
  puts PI
end

/ 1st major function modules: act as namespaces
  use double colon, c++ style refence constants
  notice inside module didn't need full scope constant
  important! reopening Geometry module add stuff to it
  similiar c# split class across files 
    that pieces together files into a complete static blueprint
    classes and modules can be reopen any time at runtime
    no way of knowing maybe later reopen again and new things added
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
# Modules as mixins!
module Loud
  def honk
    puts "I'm #{self}.  HONK!"
  end
end

str = "George"
str.extend(Loud)

str.honk

puts str.singleton_methods
/ true power of modules, mix them in to objects
  objects then gain the methods, behavior.
  means beyond inheritance to share behavior.
  think if declaring an interface pulled in an implementation
  as well
  extend on an object adds it as a singleton method
  we'll see exactly how they interact with the method call
    chain when we see them used with classes
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

class Time
  now
end

/ been going backwards - object singletons, modules, class
  classes look superficially like in other languages, but
    as we've seen objects work quite differently in ruby
  in fact classes are just objects!
  object singletons and modules provide the basis for metapgramming
/
--------------------0

class Human
  def initialize(name)
    @name = name
  end
end

ed = Human.new('Ed')
ed.instance_variable_get('@name')

/ constant name like module
  initialize constructor.  gets called when we new
  class keyword starts a new class scope
    methods defined here are callable by instances
    use instance variable syntax directly inside methods
    outside we have to use reflection api, to break abstraction
/

--------------------0
class Human
  def name
    @name
  end

  def name=(name)
    @name = name
  end
end

puts ed.name
ed.name = 'Edd'
puts ed.name

/ no return value
  methods can end with '='.  look like a setter, property
    but just a method! consistent
    syntactic sugar for name=('Edd')
/
--------------------0
# We typed 'name' 6 times to get a simple getter and setter

class Human
  attr_reader :age    # generate: def age()
  attr_writer :age    # generate: def age=(age)
  attr_accessor :eye_color, :hair_color
  
  def greet
    puts "I'm #{@name}, and I'm #{@age}."
  end
end

baby = Human.new('joey')
baby.age = 1
baby.greet

/ accessor generates both.  all versions can take multiple
  unlike c# generated getters\/setters, these aren't a complier
    hack that build a field you can never access, but are 
    actually setting instance variables in our object.
    so we could extend with our VariableSerializer
/
--------------------0