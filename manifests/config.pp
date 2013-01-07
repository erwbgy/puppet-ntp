class ntp::config (
  $servers, # array
  $iburst,  # bool
) {
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
