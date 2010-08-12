--------------------0
# DSLs
Domain Specific Languages

buzzword circa ~2006

"a computer language that's targeted to a particular kind of problem"
 -Martin_Fowler
 
see 'http://martinfowler.com/bliki/DomainSpecificLanguage.html'
/ the nosql and html5 of yesterday
/
--------------------0
# DSLs properties

context based
domain vocabulary 
units
language as building blocks

/ our brains well adapted to language
  long tradition before OO.
  unix mini-languages.  
  Yak & Lexx, Antlr.  Justin's Meta Sharp
/
--------------------0
# DSLs Internal vs External at a glance (IMO!)

internal do
  learn :some
  build :easy
  reads :ok
  helps :programmers
end

external do
  learn :alot
  build :hard
  reads :great
  helps :end_users
end

# external dsl:
'award 3 points if user is a gold member and its tuesday'

# internal dsl in ruby
award 3.points if user.gold_member? and tuesday?