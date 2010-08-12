--------------------0
# DSLs
Domain Specific Languages

buzzword circa ~2006

"a computer language that's targeted to a particular kind of problem"
 -fowler
 
see 'http://martinfowler.com/bliki/DomainSpecificLanguage.html'
/ the nosql and html5 of yesterday
/
--------------------0
# DSLs properties

context based
domain vocabulary 
units
language as building blocks not objects and hierarchies

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
'award 3 points if user is a gold member'

# internal dsl in ruby
award 3.points if user.gold_member?

/
/
--------------------0
# Fake Example - Zero Accidental complexity
class PointsCalculator
  def calculate
    # ...
  end
  
  def save
    # ...
  end
  
  log_methods :calculate, :save
  
end

--------------------0

easy to make?
easy to modify?
easy to integrate?
easy to distribute?

/ grammars, AST's, parsing 
    fun stuff, some know it, some learn it
    few languages integrate it (Boo, Groovy, Perl6)
  my main concern - contract to build 'customer points'
  dsl for business analysts to modify.  great, use external 
  dsl remove :'s and ()'s for end-user facing language.
  What about hundreds of small problems -- accidental complexity --
  of the project?  Caching, manage db schema, ORM, authorization,
  logging.  Luckily frameworks handle these -- probably xml
  config, not ideal, at least not write yourself. inevitably problems
  or pieces of code repeat throughout project you'd like to abstract
  away.  Only tool is a grammar hammer, 9 out of 10 times not worth the time?
/

--------------------0

techniques dsl generalization of OO principles

  # $ gem install gravatar
  
  require 'gravatar'
  
  class User
    def mail
      'mike@email.com'
    end
    gravatar :mail
  end
  
  mike = User.new
  mike.gravatar.url