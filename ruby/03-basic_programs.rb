2. ruby basics

--------------------0
# Ruby basic program 2
puts "Hello World!"

/ puts prints the string to stdout with \n.  
    not a keyword, just a method with the () off
  running inside implicit main object
  ruby programs are constructed with classes, scripts this is nice
/
--------------------0
# Ruby basic program 2

3.times { puts 'hi' }

/ numbers are full objects with behavior
    no primitives
  {} is a 'block'.  really important, great design.
    shorthand lamdba syntax - create code that isn't executeded immediately
    instead its passed to the method
/
--------------------0
# Ruby basic program 2 other language equivalents

3.times { puts 'hi' }

# C# assuming an Integer.Times expansion method:

3.Times(() => System.Console.WriteLine("hi"))

# Javascript assuming Number.prototype.times function:

(3).times(function () { alert("hi")})

# alternate syntax do/end:
3.times do
  puts 'hi'
end

--------------------0
# Ruby basic program 3 IO and string interpolation
name, ext = "what_sup", "txt"
path = "/tmp/#{name}.#{ext}"
content = "not much"

File.open(path, 'w') do |file|
  file.puts content
end

text = File.read(path)
puts "read from #{path}: #{text}"

/ double assignment on first line, nice sometimes
  inline interpolation
  simliar using in c#, just one of many uses of blocks
  shorthand to read all of file
  blocks act as closure
/
--------------------0
# Ruby basic program 4 inventory tracker

inventory = { 'ipod' => 12, 'ball'=> 50 }

loop do
  puts "Inventory: #{inventory.inspect}.  Buy?"
  input = gets.chomp
  break if input == 'q'
  inventory[input] -= 1 if inventory.include?(input)
end
/ break unless input.length > 2
  closure inventory
/
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
--------------------0

1. parenthesis are optional
2. hash literal
3. post conditionals
4. unless conditional
5. numbers are objects
6. string interpolation
7. implicit main context 
8. method blocks syntax
9. blocks are closures
10. interactive console!

/ nice features for day to day work
  basic, procedural coding
  modern OO languages look probably have these
/