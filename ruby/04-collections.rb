# Enumeration

[1, 10, 100].each {|el| puts el }

/ for loop is rarely used, by newbs
  push based system, we don't control iteration
    just suply a block let method handle looping
/
--------------------0
# Enumeration useful methods

items = [1, 10, 100]

items.map    {|el| el * 2 }
items.reject {|el| el > 50 }
items.any?   {|el| el / 50 }
items.find   {|el| el == 10 }
items.uniq

/ great to have built in
    know if have linq
    others for loops or CollectionUtils
/
--------------------0
# Enumeration mutability

names = ['bob', 'don', 'tom']

p names.map {|s| s.upcase }
p names

p names.map! {|s| s.upcase }
p names

--------------------0
# Aside on !

# like ?, no inherit language semantics

# use for more suprising version of method:
User.find('bob')    # => nil
User.find!('bob')   # raise an error!

# use in dsl methods
User.table.delete!

/ 
/
--------------------0
# Enumeration wrapup

1. powerful methods on([], {}, your_class.each)
2. most methods copy but mutate with a bang!
3. cool? hell_yeah!
