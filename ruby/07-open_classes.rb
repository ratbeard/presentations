# Open classes - with great power…
class Fixnum
  def +(other)
    42
  end
end
/ changing behavior is almost always bad idea
/
--------------------0
# Open classes - update older ruby versions

class Fixnum
  def odd?
    self % 2 == 1
  end unless instance_methods.include? 'odd?'
  
  def even?
    self % 2 == 0
  end unless instance_methods.include? 'even?'
end
/ good usage.  1.8.6 and earlier doesn't have these methods
  only defining them if not already defined
  clear semantics, if two libraries did both overwrite, pretty
    sure they would behave the same.
/
-----------------0
# Extend core classes - cleaner implementation
class Array
  def extract_options!
    if last.is_a?(Hash)
      pop
    else
      {}
    end
  end
end

# now we can:
def our_method(*args)
  options = args.extract_options!
  # ...
end

/ convenient, a little dangerous
  protection by using well known 'extensions' library - activesupport
    everyone wrote their own activesupport, clashes
/
--------------------0
# Open classes - units in a DSL
class Numeric
  KILOBYTE = 1024
  MEGABYTE = KILOBYTE * 1024

  def bytes
    self
  end
  alias :byte :bytes

  def kilobytes
    self * KILOBYTE
  end
  alias :kilobyte :kilobytes

  def megabytes
    self * MEGABYTE
  end
  alias :megabyte :megabytes
end

puts 1.byte + 2.megabytes - 17.kilobytes

/ from rails activesupport
  normalize to a common base unit (bytes)
/
--------------------0
# Open classes - units in a DSL

4.years + 4.months + 1.day
3.month.from_now
2.fortnights.ago
1.second.from_now.future?
