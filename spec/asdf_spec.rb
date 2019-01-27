# # encoding: utf-8

# Inspec test for recipe install-py-rb-go::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# Check command
RSpec.shared_context 'check_command' do
	its('stderr') { should eq '' }
	its('exit_status') { should eq 0 }
end

# check asdf directory
ghq_root = "#{ENV['HOME']}/.ghq"
ghq_asdf_path = "#{ghq_root}/github.com/asdf-vm/asdf"
describe file(ghq_asdf_path) do
	its('type') { should eq :directory }
end
asdf_root = "#{ENV['HOME']}/.asdf"
describe file(asdf_root) do
	its('type') { should eq :symlink }
	its('link_path') { should eq ghq_asdf_path }
end

# check asdf command
describe command("bash -lc 'asdf --version'") do
	include_context 'check_command'
end
languages = [{name:"ruby", version:"2.4.1"}, {name:"python", version:"3.7.2"}, {name:"golang", version:"1.11"}]
# languages = [{name:"ruby", version:"2.4.1"}]
# languages = [{name:"ruby", version:"2.4.1"}, {name:"python", version:"3.7.2"}]
languages.each{|language|
	describe command("bash -lc 'asdf plugin-list'") do
		include_context 'check_command'
		its('stdout') { should match "#{language[:name]}" }
	end
	describe command("bash -lc 'asdf where #{language[:name]}'") do
		include_context 'check_command'
		its('stdout') { should include "#{language[:name]}" }
	end
	describe command("bash -lc 'asdf list #{language[:name]}'") do
		include_context 'check_command'
		its('stdout') { should include "#{language[:version]}" }
	end
	describe command("bash -lc 'asdf which #{language[:name]}'") do
		include_context 'check_command'
		its('stdout') { should include "#{language[:version]}" }
	end
	describe command("bash -lc 'asdf current #{language[:name]}'") do
		include_context 'check_command'
		its('stdout') { should include "#{language[:version]}" }
	end
}
# describe command("bash -lc 'asdf plugin-list'") do
# 	include_context 'check_command'
# 	its('stdout') { should match /ruby/ }
# 	its('stdout') { should match /python/ }
# 	its('stdout') { should match /golang/ }
# end

# check listed of package
# asdf_package_path = "#{asdf_root}/shims"
# describe gem('travis', "#{asdf_package_path}/gem") do
#   it { should be_installed }
# end
# describe pip('aws', "#{asdf_package_path}/pip") do
#   it { should be_installed }
# end

# check to exit command
# commands = ["travis", "aws"]
# commands.each{|command|
# 	describe command("bash -lc '#{command} --version'") do
# 		include_context 'check_command'
# 	end
# }

# describe command("which curl") do
# 	include_context 'check_command'

# 	its('stdout') { should match /\/usr\/bin\/curl/ }
# end
