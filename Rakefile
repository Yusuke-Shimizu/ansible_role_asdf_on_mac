require 'rake'
require 'rspec/core/rake_task'

task :serverspec    => 'serverspec:all'
task :default => :serverspec

namespace :serverspec do
  targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    target = File.basename(dir)
    target = "_#{target}" if target == "default"
    targets << target
  end

  task :all     => targets
  task :default => :all

  targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/#{original_target}/*_spec.rb"
    end
  end
end

namespace :inspec do
  desc "Run Inspec tests"
  task :default do
    sh 'inspec exec spec/asdf_spec.rb'
  end
end
