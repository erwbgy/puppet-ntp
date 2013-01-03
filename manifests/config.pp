class ntp::config (
  $servers = undef,
  $iburst = undef,
) {
  if $servers == undef {
    fail('ntp::config servers parameter must be supplied')
  }
  if $iburst == undef {
    fail('ntp::config iburst parameter must be supplied')
  }
  # defaults
  File {
    owner => 'root',
    group => 'root',
  }
  file { '/etc/ntp.conf':
    ensure  => present,
    mode    => '0444',
    content => template('ntp/ntp.conf.erb'),
    require => Class['ntp::install'],
    notify  => Class['ntp::service'],
  }
}
