!SLIDE
#Let's Integrate With Cucumber

!SLIDE
#Extending the World
<pre class="sh_ruby">
# features/support/env.rb

World(VagrantHelpers)
</pre>

<pre class="sh_ruby">
# features/support/env.rb

World do
  VagrantEnabledWorld.new
end
</pre>

!SLIDE
<pre class="sh_ruby">
class VagrantEnabledWorld

  at_exit {
    if ENV['KEEP_RUNNING'] != "true"
      new.vagrant_env.cli('destroy', '-f')
    end
  }

  def initialize
    @project_root = File.expand_path('../../../', __FILE__)
    @vagrant_root = File.join(@project_root,
                              'features/support/CO')
  end

  def vagrant_env
    @vagrant ||= Vagrant::Environment.new({
      :cwd => @vagrant_root })
  end

  def run_command(command, options={})
    run_vagrant_command(:execute, command, options)
  end

  # ... more things here
end
</pre>

!SLIDE
<pre class="sh_ruby">
Given /^I have a running CentOS VM$/ do
  @pwd = Dir.pwd
  File.exists?(
    File.join(@vagrant_root, 'Vagrantfile')
  ).should == true

  vagrant_env.cli('up')
  invoke_sandbox_command('on')
end

Given /^I have Puppet available$/ do
  run_command('which puppet', :silent => true)
end

Then /^I should have Jenkins installed$/ do
  run_command('/vagrant/verify-jenkins-install')
end
</pre>

!SLIDE
<pre class="sh_ruby">
Feature: Running Puppet
  Background:
    Given I have a running CentOS VM
    And I have Puppet available

  Scenario: Installing Jenkins
    Then I should have Jenkins installed
    And it should be running

  Scenario: Installing Jenkins plugins
    Then I should have the Vagrant plugin installed
</pre>
