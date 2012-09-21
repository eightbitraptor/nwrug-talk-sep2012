!SLIDE
#Introducing Kuroko
##Cucumber Vagrant integration

!SLIDE
<pre class="sh_ruby">
require 'kuroko'

project_root = File.expand_path('../../../', __FILE__)
vagrant_root = File.join(project_root, 'features/centos')

Kuroko.configure do |config|
  config.vagrant_root = vagrant_root
end
</pre>

!SLIDE
<pre class="sh_ruby">
Given /^I have a running CentOS VM$/ do
  vagrant_cli_command('up')
end

Given /^I have Puppet available$/ do
  run_vagrant_command('which puppet', :silent => true)
end

Then /^I should have Jenkins installed$/ do
  run_vagrant_command('/vagrant/verify-jenkins-install')
end

And /^it should be running$/ do
  run_sudo_command('/sbin/service jenkins status')
end

Then /^I should have the (.*) plugin installed$/ do |name|
  plugin = name.downcase
  run_vagrant_command("/vagrant/verify-plugin #{plugin}")
end
</pre>

!SLIDE
#One Tiny Cucumber Monkey Patch
<pre class="sh_ruby">
module Cucumber
  module RbSupport
    class RbLanguage
      alias_method :extend_world_original, :extend_world

      def extend_world
        @current_world.extend(Kuroko::VagrantSupport)
        extend_world_original
      end
    end
  end
end
</pre>

!SLIDE
##Jumps in between creating and extending the World
##You can still extend the World Object
##New Worlds will still have Kuroko as an ancestor

!SLIDE
## `bundle exec cucumber`
## Or
## `bundle exec cucumber KEEP_RUNNING=1`

!SLIDE
<pre class="sh_ruby">
at_exit {

  if ENV['KEEP_RUNNING'] != "true"
    new_env = Object.new.extend(self).send(:vagrant_env)
    new_env.cli('destroy', '-f')
  end

}
</pre>

!SLIDE
#Patches and Pull requests welcome
#=)
##http://github.com/eightbitraptor/kuroko

!SLIDE
#Demo

!SLIDE
#Thanks
#Questions?
