# Project: vagrantnode
# Author: S. Guclu
# description: main driver script for Puppet
# read more puppet syntax @ http://www.puppetcookbook.com/
#make sure the puppet is installed on the .box otherwise rest of the puppet provisioning will not function
group { "puppet":
ensure => "present",
}

user { 'vagrant': 
  ensure   => present,
  password => '$1$eIqlEIzY$zPj3zDvToC8rMnPbdKZv70',
}
 
host { 'cinode':
    ip => '192.168.1.12',
}
 
File { owner => 0, group => 0, mode => 0644 }
file { '/etc/motd':
content => "CENTOS 64 BITS GENERATED NODE (Puppet over Vagrant)\n"
}

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

node /centos64autoslave.*/ {
  class { 'jenkins::slave':
    masterurl => 'https://cinode:44312',
    ui_user => 'almuser',
    ui_pass => 'A12lmuseR',
  }
}

# node /jenkins-master.*/ {
# node  /centos64autoslave.*/ {
#    include jenkins
#    include jenkins::master
#}
