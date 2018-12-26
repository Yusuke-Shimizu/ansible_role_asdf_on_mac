# # encoding: utf-8

# Inspec test for recipe install-py-rb-go::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# check asdf command
describe command("bash -lc 'asdf --version'") do
	include_context 'check_command'
end
describe command("bash -lc 'asdf plugin-list'") do
	include_context 'check_command'
	its('stdout') { should match /ruby/ }
	its('stdout') { should match /python/ }
	its('stdout') { should match /golang/ }
end

# check listed of package
asdf_package_path = "#{ENV['HOME']}/.asdf/shims"
describe gem('travis', "#{asdf_package_path}/gem") do
  it { should be_installed }
end
describe pip('aws', "#{asdf_package_path}/pip") do
  it { should be_installed }
end

# check to exit command
commands = ["travis", "aws"]
commands.each{|command|
	describe command("bash -lc '#{command} --version'") do
		include_context 'check_command'
	end
}
