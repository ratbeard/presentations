next_steps do
  google "try ruby" # in the browser!
  install_ruby
  run 'irb'
  make "sinatra webapp", :deploy => :heroku, :cost => :free!
  try "rake"              # for scripting
  try "cucumber, webrat"  # web testing
  try "rails"
  try "ironruby, jruby"
end

books  'The Well-Grounded Rubyist
        Ruby Best Practices
        Ruby in Practice'

