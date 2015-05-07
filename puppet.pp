# Project: vagrantnode
# Author: S. Guclu
# description: main driver script for Puppet
# read more puppet syntax @ http://www.puppetcookbook.com/

#make sure the puppet is installed on the .box otherwise rest of the puppet provisioning will not function
group { "puppet":
ensure => "present",
}

# vagrant account password reset to connect
user { 'vagrant': 
  ensure   => present,
  password => '$1$eIqlEIzY$zPj3zDvToC8rMnPbdKZv70',
}
 
# /etc/host setup with private address  
host { 'cinode':
    ip => '192.168.1.12',
}

# java truststore update with root CA
java_ks { 'puppetca:truststore':
  ensure       => latest,
  certificate  => '/tmp/cacerts',
  target       => '/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.79-2.5.5.1.el7_1.x86_64/jre/lib/security/cacerts',
  password     => 'changeit',
  trustcacerts => true,
}

# various options 
File { owner => 0, group => 0, mode => 0644 }
file { '/etc/motd':
content => "CENTOS 64 BITS GENERATED NODE (Puppet over Vagrant)\n"
}

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

# slave registration through swarm plugin
node /centos64autoslave.*/ {
  class { 'jenkins::slave':
    masterurl => 'https://cinode:8081',
    ui_user => 'almuser',
    ui_pass => 'A12lmuseR',
    disable_ssl_verification => true,
    executors => 4,
    labels => 'autoslave'
  }
}

# node /jenkins-master.*/ {
# node  /centos64autoslave.*/ {
#    include jenkins
#    include jenkins::master
#}
