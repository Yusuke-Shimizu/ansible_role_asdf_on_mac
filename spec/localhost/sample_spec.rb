require 'spec_helper'

describe package('ansible') do
	it { should be_installed }
end

describe command('ansible --version') do
	its(:exit_status) { should eq 0 }
end

describe command('which serverspec-init') do
	its(:exit_status) { should eq 0 }
end

describe command("bash -lc 'asdf --version'") do
	its(:exit_status) { should eq 0 }
end
