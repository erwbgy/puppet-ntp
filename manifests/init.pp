class ntp (
  $use_extlookup = false,
  $use_hiera     = false,
  $servers       = undef,
  $country       = undef,
  $continent     = undef
) {
  if $use_hiera {
    $_servers   = hiera('ntp_servers',   undef)
    $_country   = hiera('ntp_country',   undef)
    $_continent = hiera('ntp_continent', undef)
  }
  elsif $use_extlookup {
    $_servers   = extlookup('ntp_servers',   undef)
    $_country   = extlookup('ntp_country',   undef)
    $_continent = extlookup('ntp_continent', undef)
  }
  else {
    $_servers   = $servers
    $_country   = $country
    $_continent = $continent
  }

  case $_continent {
    'africa':        {}
    'asia':          {}
    'europe':        {}
    'north-america': {}
    'oceania':       {}
    'south-america': {}
    default: {
      notify { "ntp: unknown continent '${_continent}' specified - known good values are: 'europe', 'asia', 'oceania', 'north-america', 'south-america', 'africa'": }
    }
  }

  if $_servers {
    $_serverlist = $_servers
  }
  elsif $_country {
    $_serverlist = [
      "0.${_country}.pool.ntp.org",
      "1.${_country}.pool.ntp.org",
      "2.${_country}.pool.ntp.org",
    ]
  }
  elsif $_continent {
    $_serverlist = [
      "0.${_continent}.pool.ntp.org",
      "1.${_continent}.pool.ntp.org",
      "2.${_continent}.pool.ntp.org",
    ]
  }
  else {
    $_serverlist = [
      '0.pool.ntp.org',
      '1.pool.ntp.org',
      '2.pool.ntp.org',
    ]
  }

  class { 'ntp::config':
    servers => $_serverlist
  }
  include ntp::install
  include ntp::service
}
