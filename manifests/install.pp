class ntp::install {
  package { [
    'ntp',
    'ntpdate'
  ]:
    ensure => installed,
  }
}
