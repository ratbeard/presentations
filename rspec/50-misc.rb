# load path tip!

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'spec_helper'
-------------------0
# Rspec 2!

# metagem
http://github.com/rspec/rspec

- http://github.com/rspec/rspec-core
- http://github.com/rspec/rspec-expectations
- http://github.com/rspec/rspec-mocks

-------------------0
# metadata
  
def assign_auto_description
  if description.empty?
    metadata[:description] = RSpec::Matchers.generated_description
    RSpec::Matchers.clear_generated_description
  end
end
