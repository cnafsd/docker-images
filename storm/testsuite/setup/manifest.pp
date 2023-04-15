include epel
include umd4
include testca
include sdds_users

include voms::dteam
include voms::testvo
include voms::testvo2

file { '/etc/grid-security':
  ensure => directory,
}

class { 'storm::repo':
  enabled => ['stable'],
}

$packages = [
  'openldap-clients',
  'globus-gass-copy-progs',
  'gfal2-util',
  'gfal2-all',
  'storm-srm-client',
  'davix',
  'myproxy',
  'voms-clients',
  'voms-clients-java',
]

package { 'dcache-srmclient-3.0.9-1':
  ensure  => 'installed',
  require => [Class['umd4']],
}

package { $packages:
  ensure  => 'latest',
  require => [Class['umd4']],
}

yumrepo { 'voms-0621-01':
  ensure   => present,
  descr    => 'voms unreleased rpms',
  baseurl  => 'https://ci.cloud.cnaf.infn.it/view/voms/job/pkg.voms/job/v0621.01/lastSuccessfulBuild/artifact/artifacts/stage-area/centos7',
  enabled  => 1,
  protect  => 1,
  priority => 1,
  gpgcheck => 0,
}

class { 'python':
  version => '3.4',
  pip     => 'present',
  dev     => 'present',
}

package { 'robotframework':
  ensure   => installed,
  require  => Class['python'],
  provider => 'pip3',
}
package { 'robotframework-httplibrary':
  ensure   => installed,
  require  => [Class['python'], Package['robotframework']],
  provider => 'pip3',
}
package { 'robotframework-jsonlibrary':
  ensure   => installed,
  require  => [Class['python'], Package['robotframework']],
  provider => 'pip3',
}
package { 'requests':
  ensure   => installed,
  require  => [Class['python'], Package['robotframework']],
  provider => 'pip3',
}
package { 'pyyaml':
  ensure   => installed,
  require  => [Class['python'], Package['robotframework']],
  provider => 'pip3',
}
package { 'shyaml':
  ensure   => installed,
  require  => [Class['python'], Package['robotframework']],
  provider => 'pip3',
}

class { 'java' :
  package => 'java-1.8.0-openjdk-devel',
}

user { 'tester':
  ensure     => present,
  name       => $title,
  password   => Sensitive('password'),
  managehome => true,
  groups     => ['wheel'],
}

sudo::conf { 'tester':
  content => 'tester ALL=(ALL) NOPASSWD: ALL',
  require => [User['tester']],
}

Class['epel']
-> Class['umd4']
-> Class['python']
-> Class['java']
-> Class['sdds_users']
-> File['/etc/grid-security']
-> Class['voms::dteam']
-> Class['voms::testvo']
-> Class['voms::testvo2']
-> Class['testca']
-> Class['storm::repo']
-> Yumrepo['voms-0621-01']
-> Package['robotframework']
-> User['tester']
