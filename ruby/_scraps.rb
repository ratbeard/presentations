

http://ruby.dzone.com/news/dynamically-created-methods-ru

advanced, by ola.

http://mwrc2009.confreaks.com/13-mar-2009-18-10-jive-talkin-dsl-design-and-construction-jeremy-mcanally.html

talk

http://yonkeltron.com/2010/05/13/creating-a-ruby-dsl/

house example

http://gist.github.com/303794


implement an abstraction!


class Trash
  def dispose
    puts "time to take out the #{self.class}"
  end
end

using(Trash.new) do |t|
  puts "got some trash: #{t}"
end



module ActiveSupport

  # Wrapping a string in this class gives you a prettier way to test

  # for equality. The value returned by <tt>Rails.env</tt> is wrapped

  # in a StringInquirer object so instead of calling this:

  #

  #   Rails.env == "production"

  #

  # you can call this:

  #

  #   Rails.env.production?

  #

  class StringInquirer < String

    def method_missing(method_name, *arguments)

      if method_name.to_s[-1,1] == "?"

        self == method_name.to_s[0..-2]

      else

        super

      end

    end

  end

end

implement a pattern!

===

active_support/core/module/delegation

def delegate(*methods)

  options = methods.pop

  unless options.is_a?(Hash) && to = options[:to]

    raise ArgumentError, "Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, :to => :greeter)."

  end

  

  # start a class declaration block

  class_eval do

    methods.each do |method|

      define_method(method) do |*args|

        receiver = send(to)

        receiver.send(method, *args)

      end

    end

  end

end

delegate :hi, :ho, :to => :mike



ruby -e "puts $:"

  def included(klass)

    super

    klass.private_class_method  :new, :allocate

    klass.extend SingletonClassMethods

    Singleton.__init__(klass)

  end

class A; include Singleton; end

  def __init__(klass)

    klass.instance_eval { @__instance__ = nil }

    class << klass

      define_method(:instance,FirstInstanceCall)

    end

    klass

  end



uses:

- web applications (rails, sinatra)

- driving other programs (scripting, testing)

- text processing



castanaut

===

http://github.com/joseph/castanaut/blob/master/lib/castanaut/movie.rb

# castanaut screencasting automation
# http://gadgets.inventivelabs.com.au/castanaut


launch "Safari"
url "http://gadgets.inventivelabs.com.au"
ishowu_start_recording

while_saying "To install it, drag it to your bookmarks bar." do
  move to_element("a.button")
  drag to(88, 106)
  pause 0.5
  hit Enter
end

while_saying "Let's try it out on delicious." do
  url "http://del.icio.us"
  pause 2
end