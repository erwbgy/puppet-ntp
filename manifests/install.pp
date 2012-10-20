class ntp::install {
  realize( Package[ 'ntp', 'ntpdate' ] )
}
