class ntp::install {
  case $::operatingsystem {
    'RedHat', 'CentOS', 'OracleLinux', 'Amazon': {
      if ! defined(Package['ntp']) {
        package { 'ntp':  ensure => installed }
      }
      if versioncmp($::operatingsystemrelease, '6.0') > 0 {
        if ! defined(Package['ntpdate']) {
          package { 'ntpdate':  ensure => installed }
        }
      }
    }
    default: {
      fail('Currently only works on RedHat-like systems')
    }
  }
}
