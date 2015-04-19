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
 
File { owner => 0, group => 0, mode => 0644 }
file { '/etc/motd':
content => "CENTOS 64 BITS GENERATED NODE (Puppet over Vagrant)\n"
}

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

#class system-update {
#  exec { 'apt-get update':
#    command => 'apt-get update',
#  }

#  $sysPackages = [ "build-essential" ]
#  package { $sysPackages:
#    ensure => "installed",
#    require => Exec['apt-get update'],
#  }
#}

# class tomcat7 {
 
#  package { "tomcat7":
#    ensure => present,
#    require => Class["system-update"],
#  }
 
#  service { "tomcat7":
#    ensure => "running",
#    require => Package["tomcat7"],
#  }
# 
# }
 
# include tomcat7
# include system-update

# S. GUCLU : tweak used to generate missing links on Tomcat 7 for runtime
# file { '/var/lib/tomcat7/bin':
#   ensure => 'link',
#   require => Package["tomcat7"],
#   target => '/usr/share/tomcat7/bin',
#}
#file { '/var/lib/tomcat7/lib':
#   ensure => 'link',
#   require => Package["tomcat7"],
#   target => '/usr/share/tomcat7/lib',
#}

# S. GUCLU : tweak used to disable authentication issues on sudo-managed deployments
#file { '/tmp/sudo-update.sh':
#   ensure => 'present',
#   mode => '+x',
#   require => Package["tomcat7"],
#   content => 'echo "vagrant ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/vagrant',
#}

#exec { 'sudo all for vagrant user':
#   command => 'sudo /tmp/sudo-update.sh',
#   require => File["/tmp/sudo-update.sh"],
#}

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
