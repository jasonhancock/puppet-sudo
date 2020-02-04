# Class: sudo
#
# Sets up sudo.
class sudo (
  $package_ensure='installed',
) {
  package { 'sudo':
    ensure  => $package_ensure,
  }

  file { '/etc/sudoers.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    purge   => true,
    recurse => true,
    require => Package['sudo'],
  }

  file { '/etc/sudoers':
    ensure  => present,
    content => template('sudo/default.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    require => Package['sudo'],
  }

  if $::environment == 'vagrant' {
    sudo::conf { 'vagrant':
      content => "Defaults:vagrant !requiretty\n%vagrant ALL=(ALL) NOPASSWD: ALL",
    }
  }
}
