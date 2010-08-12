

http://ruby.dzone.com/news/dynamically-created-methods-ru

advanced, by ola.

http://mwrc2009.confreaks.com/13-mar-2009-18-10-jive-talkin-dsl-design-and-construction-jeremy-mcanally.html

talk

http://yonkeltron.com/2010/05/13/creating-a-ruby-dsl/

house example

http://gist.github.com/303794


implement an abstraction!

def using(object) 

  raise "object isnt disposable" unless object.respond_to? :dispose

  yield object    # pass the given object to the given block

  object.dispose  # now trash it!

end

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

rspec

===

http://github.com/dchelimsky/rspec

describe Account do

    context "transfering money" do

      it "deposits transfer amount to the other account" do

        source = Account.new(50, :USD)

        target = mock('target account')

        target.should_receive(:deposit).with(Money.new(5, :USD))

        source.transfer(5, :USD).to(target)

      end

      it "reduces its balance by the transfer amount" do

        source = Account.new(50, :USD)

        target = stub('target account')

        source.transfer(5, :USD).to(target)

        source.balance.should == Money.new(45, :USD)

      end

    end

  end



sinatra

===

http://www.sinatrarb.com/intro

require 'rubygems'

require 'sinatra'

get '/hi' do

  "Hello World!"

end

# Install the gem and run with:

#  sudo gem install sinatra

#  ruby myapp.rb

#

# View at: localhost:4567

homebrew

===

http://github.com/mxcl/homebrew/blob/master/Library/Formula/wget.rb

require 'formula'

# iri support requires libidn, which pulls in getteext, so we

# disable this by default.

class Wget <Formula

  homepage 'http://www.gnu.org/software/wget/'

  url 'http://ftp.gnu.org/gnu/wget/wget-1.12.tar.bz2'

  md5 '308a5476fc096a8a525d07279a6f6aa3'

  depends_on "libidn" if ARGV.include? "--enable-iri"

  def options

    [["--enable-iri", "Enable iri support (which pulls in libidn and gettext.)"]]

  end

  def install

    args = ["--disable-debug", "--prefix=#{prefix}"]

    args << "--disable-iri" unless ARGV.include? "--enable-iri"

    system "./configure", *args

    system "make install"

  end

end

webrat

===

http://github.com/brynary/webrat

class SignupTest < ActionController::IntegrationTest

    def test_trial_account_sign_up

      visit home_path

      click_link "Sign up"

      fill_in "Email", :with => "good@example.com"

      select "Free account"

      click_button "Register"

    end

  end



castanaut

===

http://github.com/joseph/castanaut/blob/master/lib/castanaut/movie.rb

http://gadgets.inventivelabs.com.au/castanaut

plugin "safari"

plugin "mousepose"

plugin "ishowu"

launch "Mousepose"

launch "Safari", at(20, 40, 1024, 768)

url "http://gadgets.inventivelabs.com.au"

ishowu_set_region at(4, 24, 1056, 800)

ishowu_start_recording

while_saying "

  Tabulate is a bookmarklet developed by Inventive Labs. 

  You use it to open links on a web page. 

  It's meant for iPhones, but we'll demonstrate it in Safari 3.

" do

  move to(240, 72)

  tripleclick

  type "http://gadgets.inventivelabs.com.au/tabulate"

  hit Enter

  pause 2

end

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