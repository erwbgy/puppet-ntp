# puppet-ntp

Puppet module for managing the Network Time Server daemon (ntpd) on a Linux host.

Currently only works on Redhat-like systems.

## Parameters

*servers*: a list of time server hostnames

*country*: the country code (eg. _de_ for Germany or _uk_ for United Kingdom)

*continent*: one of: _europe_, _asia_, _oceania_, _north-america_, _south-america_, _africa_

*use_hiera*: get the list of time server hostnames using hiera

*use_extlookup*: get the list of time server hostnames using extlookup

## Examples

Use default pool.ntp.org time servers:

    class { 'ntp': }

Specify a list of time servers to use:

    class { 'ntp':
      servers => [ 'ntp1.domain.com', 'ntp2.domain.com' ],
    }

Use time servers from the United Kingdom:

    class { 'ntp':
      country => 'uk',
    }

Use time servers from Asia:

    class { 'ntp':
      continent => 'asia',
    }

Look up configuration using hiera:

    class { 'ntp':
      use_hiera => true,
    }

Look up configuration using extlookup:

    class { 'ntp':
      use_extlookup => true,
    }

### Hiera configuration

Add ntp_servers, ntp_country or ntp_continent parameters to a hiera
config file.  For example in /etc/puppet/hieradata/common.yaml:

The ntp_servers variable with a list of time server hostnames (often internal hosts):

    ntp_servers:
      - ntp1.domain.com
      - ntp2.domain.com

Or the ntp_country variable with a country code:

    ntp_country: de

Or the ntp_continent variable with one of _europe_, _asia_, _oceania_,
_north-america_, _south-america_, _africa_:

    ntp_continent: africa

### Extlookup configuration

Add an ntp_servers variable with a list of time server hostnames - for
example in /etc/puppet/extdata/common.csv:

    ntp_servers,0.uk.pool.ntp.org,1.uk.pool.ntp.org

## Notes

See [How do I use pool.ntp.org](http://www.pool.ntp.org/en/use.html) for
details of the available NTP zones.  NTP servers are not available for all
countries - see the country list under each continent - so use a continent or
the default pool if your country is not listed.

## Testing

Tests are implemented using RSpec, rspec-puppet and puppetlabs_spec_helper:

    $ rake spec
    /usr/bin/ruby -S rspec spec/classes/ntp_spec.rb --color
    ............
    
    Finished in 1.02 seconds
    12 examples, 0 failures

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-ntp

