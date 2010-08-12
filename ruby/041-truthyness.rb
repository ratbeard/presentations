# Logic

true and false and nil

puts 123.nil?
puts nil.nil?

/ objects, have methods
/
--------------------0
# Logic truthyness

' false and nil are "falsey"
  everything else is "truthy" (even 0)
  logic based on truthy/falsey, not strict
    boolean operators.
  more like ?? than || in c#
  just like javascript, without all the weird
    falsey values (0, {}, [], "")'

a = nil || false || 4 || 'blamo!'
puts a

hash  = { 'name' => 'joe' }
value = hash['first_name'] || 'hank'
