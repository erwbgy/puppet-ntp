class ntp (
  $use_extlookup = false,
  $use_hiera     = false,
  $servers       = undef,
  $country       = undef,
  $continent     = undef
) {
  if $use_hiera {
    $_servers   = hiera('ntp_servers', undef)
    $_country   = hiera('ntp_country', undef)
    $_continent = hiera('ntp_continent', undef)
  }
  elsif $use_extlookup {
    $_servers   = extlookup('ntp_servers', undef)
    $_country   = extlookup('ntp_country', undef)
    $_continent = extlookup('ntp_continent', undef)
  }
  elsif $servers {
    $_servers   = $servers
    $_country   = $country
    $_continent = $continent
  }
  if !$_servers {
    if $_country {
      $serverlist = [
        "0.${_country}.pool.ntp.org",
        "1.${_country}.pool.ntp.org",
        "2.${_country}.pool.ntp.org",
      ]
    }
    elsif $_continent {
      $serverlist = [
        "0.${_continent}.pool.ntp.org",
        "1.${_continent}.pool.ntp.org",
        "2.${_continent}.pool.ntp.org",
      ]
    }
    else {
      $serverlist = [
        '0.pool.ntp.org',
        '1.pool.ntp.org',
        '2.pool.ntp.org',
      ]
    }
  }
  include ntp::install
  include ntp::config
  include ntp::service
}
