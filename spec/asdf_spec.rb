# # encoding: utf-8

# Inspec test for recipe install-py-rb-go::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

describe command("asdf --version") do
	include_context 'check_command'
end

describe command("asdf plugin-list") do
	include_context 'check_command'
	its('stdout') { should match /ruby/ }
	its('stdout') { should match /python/ }
	its('stdout') { should match /golang/ }
end

commands = ["travis", "aws"]
commands.each{|command|
	describe command("bash -lc '#{command} --version'") do
		include_context 'check_command'
	end
}
