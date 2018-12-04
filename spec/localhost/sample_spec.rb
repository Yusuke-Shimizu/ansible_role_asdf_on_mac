require 'spec_helper'

RSpec.shared_context 'check_command' do
	its(:exit_status) { should eq 0 }
	its(:stderr) { should eq '' }
end

describe package('ansible') do
	it { should be_installed }
end

describe command('ansible --version') do
	include_context 'check_command'
end

describe command('which serverspec-init') do
	include_context 'check_command'
end

describe command("bash -lc 'asdf --version'") do
	include_context 'check_command'
end

describe command("bash -lc 'asdf plugin-list'") do
	include_context 'check_command'
	its(:stdout) { should match /ruby/ }
	its(:stdout) { should match /python/ }
	its(:stdout) { should match /golang/ }
end

# check asdf lang
describe command("bash -lc 'asdf current ruby'") do
	include_context 'check_command'
	its(:stdout) { should match /2.5.3/ }
end
describe command("bash -lc 'asdf current python'") do
	include_context 'check_command'
	its(:stdout) { should match /3.7.1/ }
end
describe command("bash -lc 'asdf current golang'") do
	include_context 'check_command'
	its(:stdout) { should match /1.11/ }
end

# check lang version
describe command("bash -lc 'ruby --version'") do
	include_context 'check_command'
	its(:stdout) { should match /2.5.3/ }
end
describe command("bash -lc 'python --version'") do
	include_context 'check_command'
	its(:stdout) { should match /3.7.1/ }
end
describe command("bash -lc 'go version'") do
	include_context 'check_command'
	its(:stdout) { should match /1.11/ }
end

# 
describe command("bash -lc 'gem --version'") do
	include_context 'check_command'
	its(:stdout) { should match /2.7.6/ }
end
describe package('travis') do
	it { should be_installed.by('gem') }
end
describe command("bash -lc 'travis --version'") do
	include_context 'check_command'
end

describe command("bash -lc 'pip --version'") do
	include_context 'check_command'
	its(:stdout) { should match /10.0.1/ }
end
describe package('awscli') do
	it { should be_installed.by('pip') }
end
describe command("bash -lc 'aws --version'") do
	include_context 'check_command'
end
