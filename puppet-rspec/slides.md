!SLIDE
#So how do we test all this?

!SLIDE
#rspec-puppet
##https://github.com/rodjek/rspec-puppet
###Matchers and Expectations for Puppet manifests

!SLIDE command
$ rspec-puppet-init

!SLIDE
<pre class="sh_ruby">
# spec/spec_helper.rb
require 'rspec-puppet'

fixture_path = File.expand_path('../fixtures', __FILE__))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
end
</pre>

!SLIDE
#Puppet Resource Matchers
<pre class="sh_ruby">
describe "users::matth" do
  it { should contain_class("users::matth") }

  it { should contain_user("matth").with({
    'ensure' => 'present'
  })
end
</pre>

!SLIDE incremental bullets
#Testing Custom Resources
<pre class="sh_ruby">
class jenkins {
  jenkins::plugin::install{ 'vagrant': }
}
</pre>

    @@@ruby
    describe "jenkins" do
      it { should contain_jenkins__plugin__install('vagrant') }
    end
###Yes, that _is_ 2 underscores
###(ewww)

!SLIDE
#Testing Ordering
<pre class="sh_ruby">
it "builds an ssh directory for an existing user" do
  should contain_file('/home/matth/.ssh').
    with_require('User[matth]')
end
</pre>

!SLIDE incremental
#Tests the generated Puppet dependency tree
##So we're writing a DSL for a DSL...

!SLIDE
#So how do we test that the dependency tree is correct?
