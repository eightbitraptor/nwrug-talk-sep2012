!SLIDE center
#Test Driving Puppet
##Matt House
###@eightbitraptor

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
    command => "curl -O http://herp-derp.me/ruby-1.9.3p194-1.el6.x86_64.rpm",
    cwd => '/tmp',
    creates => '/tmp/ruby-1.9.3p194-1.el6.x86_64.rpm',
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

!SLIDE
#Exec

!SLIDE
#Package

!SLIDE
#Facter

