# Chef InSpec test for recipe blog::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/
require 'spec_helper'

describe port(8080) do
  it { should be_listening }
end

describe port(3306) do
  it { should be_listening }
end
