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

describe command("bash -lc 'asdf plugin-list'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /ruby/ }
	its(:stdout) { should match /python/ }
	its(:stdout) { should match /golang/ }
end

# check asdf lang
describe command("bash -lc 'asdf current ruby'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /2.5.3/ }
end
describe command("bash -lc 'asdf current python'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /3.7.1/ }
end
describe command("bash -lc 'asdf current golang'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /1.11/ }
end

# check lang version
describe command("bash -lc 'ruby --version'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /2.5.3/ }
end
describe command("bash -lc 'python --version'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /3.7.1/ }
end
describe command("bash -lc 'go version'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /1.11/ }
end

# 
describe command("bash -lc 'gem --version'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /2.7.6/ }
end
describe command("bash -lc 'gem list'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /travis/ }
end

describe command("bash -lc 'pip --version'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /10.0.1/ }
end
describe command("bash -lc 'pip list'") do
	its(:exit_status) { should eq 0 }
	its(:stdout) { should match /awscli/ }
end
