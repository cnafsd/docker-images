include epel
include testca
include sdds_users::sd_users
include umd::umd5

include voms::dteam
include voms::testvo
include voms::testvo2
include voms::escape
include voms::ops
include voms::wlcg
include voms::cms
include voms::atlas

$carepo = 'https://repository.egi.eu/sw/production/cas/1/current/'
$carepo_gpgkey = 'https://dist.eugridpma.info/distribution/igtf/current/GPG-KEY-EUGridPMA-RPM-3'

yumrepo { 'carepo':
  descr    => 'IGTF CA Repository',
  enabled  => 1,
  baseurl  => $carepo,
  gpgcheck => 1,
  gpgkey   => $carepo_gpgkey,
}

class { 'voms::repo':
  enabled => ['stable', 'beta'],
}

$packages = [
  'ca-policy-egi-core',
  'openldap-clients',
  'globus-gass-copy-progs',
  'gfal2-all',
  'python3-gfal2-util',
  'davix',
  'myproxy',
  'voms-clients',
  'voms-clients-java',
]

package { $packages:
  ensure => 'latest',
}

class { 'java' :
  package => 'java-1.8.0-openjdk-devel',
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
package { 'robotframework-requests':
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
-> Class['umd::umd5']
-> Class['voms::repo']
-> Yumrepo['carepo']
-> Class['java']
-> Class['python']
-> Class['sdds_users::sd_users']
-> Class['testca']
-> Class['voms::dteam']
-> Class['voms::testvo']
-> Class['voms::testvo2']
-> Class['voms::ops']
-> Class['voms::wlcg']
-> Package[$packages]
-> User['tester']
