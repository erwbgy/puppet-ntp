class ntp::config {
  # defaults
  File {
    owner => 'root',
    group => 'root',
  }
  file { '/etc/ntp/ntp.conf':
    ensure  => present,
    mode    => '0444',
    content => template('ntp/ntp.conf.erb'),
    require => Class['ntp::install'],
    notify  => Class['ntp::service'],
  }
}
