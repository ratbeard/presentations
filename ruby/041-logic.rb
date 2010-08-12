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
  logic based on truthy/falsey, not strict booleans
  more like ?? than || in c#'

a = nil || false || 4 || 'blamo!'
puts a

hash  = { 'name' => 'joe' }
value = hash['first_name'] || 'hank'

value ||= 'default value'