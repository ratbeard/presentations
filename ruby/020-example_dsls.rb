# Sinatra - simple web server
require 'rubygems'
require 'sinatra'

get '/hi' do
  "Hello World!"
end

# Install the gem and run with:
#
#  sudo gem install sinatra
#  ruby myapp.rb
-------------0
# Homebrew - OSX package management system

class Wget < Formula
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
-------------0
# Webrat - web integration test

class SignupTest < ActionController::IntegrationTest
  def test_trial_account_sign_up
    visit home_path
    click_link "Sign up"
    fill_in "Email", :with => "good@example.com"
    select "Free account"
    click_button "Register"
  end
end

-------------0
# RSpec - Behavior Driven Development Testing

describe Array do
  it { should respond_to :length, :size, :pop }
  
  context "when empty" do
    subject { [] }
    it { should be_empty }
    its(:length) { should == 0 }
  end

  context "when not empty" do
    subject { [1, 2] }
    it { should_not be_empty }
    it { should have_at_least(1).element }
  end
end


-------------0
class Book < ActiveRecord::Base
  belongs_to :author
  has_many :chapters

  validates_presence_of :title
  validates_numericality_of :price, :message => "Price must be numeric!"

  before_save :save_revision
  
  # 3rd party libraries:
  acts_as_taggable
  acts_as_cached
end

-------------0
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