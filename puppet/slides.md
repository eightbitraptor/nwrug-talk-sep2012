!SLIDE center
#Test Driving Puppet
##Matt House
###@eightbitraptor

!SLIDE center
.notes this is a job shill page

![troopers](troopers.jpg)

!SLIDE center incremental
# Puppet
## A Configuration Management Framework
### (You get to write recipes to consistently configure servers)

!SLIDE bullets
# Puppet is:
* Idempotent
* Cross Platform
* Written in Ruby

!SLIDE code
<pre class="sh_ruby">
class ruby {
  exec{ "get_ruby_1.9":
    command => "curl -O http://herp-derp.me/ruby-1.9.3-p194.rpm",
    cwd => '/tmp',
    creates => '/tmp/ruby-1.9.3-p194rpm',
    path => '/usr/bin'
  }

  package{ 'ruby-1.9.3p194-1.el6.x86_64':
    ensure => installed,
    provider => rpm,
    source => '/tmp/ruby-1.9.3p194-1.el6.x86_64.rpm',
    require => Exec['get_ruby_1.9']
  }

  file { "/etc/profile.d/path.sh":
    ensure => present,
    content => "export PATH=/opt/ruby-1.9.3/bin:$PATH",
    mode => 0755,
    owner => 'root',
  }
}
</pre>

!SLIDE bullets
<dl>
  <dt>This is not Ruby</dt>
  <dd>and you <strong>will</strong> end up hating it!</dd>
  <dt>Puppet is non-deterministic</dt>
  <dd>Always declare dependancies explicitly</dd>
</dl>

!SLIDE
#Nodes
<pre class="sh_ruby">
node sakura {
  include users::matth

  class { "otb_development":
    code_root => "/home/matth/code"
  }
}
</pre>

!SLIDE
#Classes
<pre class="sh_ruby">
class otb_development( $code_root ){

  file{ $code_root:
    ensure => directory,
  }
}

class users::matth {

  user{ "matth":
    ensure => present,
    home => '/home/matth',
  }
}
</pre>

<pre class="sh_ruby">
node sakura {
  include users::matth
}
</pre>

!SLIDE
#Exec
<pre class="sh_ruby">
exec{ "get_ruby_1.9":
  command => "curl -O http://matthou.se/ruby-1.9.3-p194.el6.rpm",
  cwd => '/tmp',
  creates => '/tmp/ruby-1.9.3-p194-1.el6.rpm',
  path => '/usr/bin'
}
</pre>

!SLIDE
#Package
<pre class="sh_ruby">
package{ 'ruby-1.9.3p194-1.el6.x86_64':
  ensure => installed,
  provider => rpm,
  source => '/tmp/ruby-1.9.3p194-1.el6.x86_64.rpm',
  require => Exec['get_ruby_1.9']
}
</pre>

<pre class="sh_ruby">
package{ "nginx":
  ensure => installed,
}
</pre>

!SLIDE
#Facter
## A library for collecting facts about your system

!SLIDE
<pre class="sh_bash">
$ facter

facterversion => 1.6.5
fqdn => sakura.otb.local
hardwaremodel => x86_64
hostname => sakura
...
</pre>

<pre class="sh_ruby">
case $::operatingsystem {
  'CentOS': { include centos}
  'MacOS': { include osx}
}
</pre>

!SLIDE
#Custom Facts
## Are written in Ruby
## Facter searches `$LOAD_PATH` for custom facts
## Puppet recommends 'plugins in modules'

!SLIDE
#Basically, shove them in lib!

!SLIDE
#Custom Facts
<pre class="sh_ruby">
require 'facter'

Facter.add("awesomelevel") do
  confine :kernel => 'Linux'
  has_weight 100

  setcode do
    Facter::Util::Resolution.exec("/bin/awesome")
  end
end
</pre>

