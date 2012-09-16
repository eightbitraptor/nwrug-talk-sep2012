!SLIDE
#Vagrant

!SLIDE
>"Vagrant uses Oracle’s VirtualBox to build configurable, lightweight, and portable virtual machines dynamically"

!SLIDE
<pre class="sh_ruby">
puppet_root = File.expand_path("../../", __FILE__))

Vagrant::Config.run do |config|
  config.vm.box = "centos63"
  config.vm.box_url = "https://herp-derp.me/CentOS-6.3-x86_64.box"

  config.vm.forward_port 8080, 12345

  config.vm.provision(:shell,
                      :path => 'resources/jenkins-gpg.sh')

  config.vm.provision(:puppet) do |puppet|
    puppet.manifests_path = puppet_root
    puppet.manifest_file = 'modules/jenkins/boxes/CO/cucumber.pp'
    puppet.module_path = File.join(puppet_root, 'qa/modules')
  end
end
</pre>

!SLIDE
#Moar Boxes!
##www.vagrantbox.es

!SLIDE command
$ vagrant up

!SLIDE command
$ vagrant ssh

!SLIDE command
$ vagrant provision

!SLIDE command
$ vagrant reload

!SLIDE command
$ vagrant destroy

!SLIDE command

!SLIDE
#Ruby API
<pre class="sh_ruby">
vagrant_env = Vagrant::Environment.new(:cwd => './')
vagrant_env.cli(:up)

if vagrant_env.primary_vm.state == :running
  vagrant_env.primary_vm.channel.send(:execute,
                                      'cowsay Yo Mamma!')
  vagrant_env.primary_vm.channel.send(:sudo, 
                                      '/bin/hostname')
end
</pre>

!SLIDE
#Not Bad...
