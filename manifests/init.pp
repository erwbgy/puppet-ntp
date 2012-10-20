class ntp (
  $servers = [
    '0.centos.pool.ntp.org',
    '1.centos.pool.ntp.org',
    '2.centos.pool.ntp.org'
  ],
  $use_extlookup = false,
  $use_hiera     = false
) {
  if $use_hiera {
    $serverlist = hiera('ntpservers', $serverlist)
  }
  elsif $use_extlookup {
    $serverlist = extlookup('ntpservers', $serverlist)
  }
  else {
    $ntp_servers = $serverlist
  }
  include ntp::install
  include ntp::config
  include ntp::service
}
