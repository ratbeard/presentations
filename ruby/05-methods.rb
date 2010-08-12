# Method
def secret
  42
end

p secret
/ no need for return, everything returns last executed expression
  same for if
/
-----------------------0
# Method with arguments
def tag(text, tag='div')
  "<#{tag}>#{text}</#{tag}>"
end

p tag('my blog')
p tag('item 1', 'li')
/ taking two arguments
  second have a default value
  default arguments must be last
  can be any expression - rand, define a class.  not common
/
-----------------------0
# Method with trailing options hash
def tag(text, options={})
  tag = options[:tag] || 'div'
  "<#{tag}>#{text}</#{tag}>"
end

puts tag('hi from div')
puts tag('hi from li', { :tag => 'li' })
/ very common in ruby, and js
  main argument, other options in hash.
/
-----------------------0
# Method sugar

tag('content', { :tag => 'li' })
tag 'content', { :tag => 'li' }
tag 'content', :tag => 'li'

/ unlike javascript
  psuedo-named arguments
  combine with optional ()'s readable dsl
/
-----------------------0
# Method with variadic arguments

def tag(tag, *lines)
  puts "no lines given :(" if lines.empty?
  lines.map {|text| "<#{tag}>#{text}</#{tag}>"}
end

puts tag("li", "item 1", "item 2", "3")
puts tag("li")
/ star or splat operator cooerces remeinaing arguments into array
  no arguments, get an empty array
  go back to old magic position api.  can't have an optional
    trailing argument, lines will soak up all remaining arguments
    no way to say we want it to go into lines vs options.
    syntax error
/
-----------------------0
# Method that calls a block

def tag(tag='div')
  text = yield
  "<#{tag}>#{text}</#{tag}>"
end

puts tag { 'im the content' }

tag 'h1' do
  puts "in a block!"
  "Page Title"
end

/ we've passed blocks to methods heres how they're called
  yield yields control to the block.
/
-----------------------0
# Method that optionally yields to a block

# Always run calculation even if won't log it, ouch:
log "Deleted row, for debugging: #{db.run_calculation}"

# Not if its in a block:
log { "Deleted row, for debugging: #{db.run_calculation}" }

def log(msg='') 
  return if logging.current_level < 'debug'
  msg = yield if block_given?
  logging.file.puts msg
end

/ error if we call yield and no block given
/
-----------------------0
# Implement a using block as a method

def using(object) 
  raise "object isnt disposable" unless object.respond_to? :dispose
  yield object    # pass the given object to the given block
  object.dispose  # now trash it!
end