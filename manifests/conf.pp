# Define: sudo::conf
#
# Use this to drop files in the /etc/sudo.d directory. Use either source or
# content, not both!
#
# Sample Usage:
#   sudo::conf { "some_group":
#     content=>"%some_group  ALL=(ALL)  ALL\n",
#   }
define sudo::conf (
  $source  = undef,
  $content = undef,
  $ensure  = present,
  $replace = true,
  ) {

  case $ensure {
    'absent': {
      file { "/etc/sudoers.d/${name}":
        ensure => absent,
      }
    }

    default: {
      file { "/etc/sudoers.d/${name}":
        owner   => 'root',
        group   => 'root',
        mode    => '0440',
        require => File['/etc/sudoers.d'],
        content => $content,
        source  => $source,
        replace => $replace,
      }
    }
  }
}
