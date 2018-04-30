require 'spec_helper'
describe 'r_profile::linux::yum' do
  context "catalog compiles" do
    it { should compile}
  end
  
  context 'with default values for all parameters' do
    it { should contain_class('r_profile::linux::yum') }
  end
end
