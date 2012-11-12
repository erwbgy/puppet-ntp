require 'spec_helper'

describe 'ntp', :type => 'class' do
  include_context 'hieradata'
  context 'no parameters' do
    let(:params) { {} }
    it {
      should create_class('ntp::config').with_servers([ '0.pool.ntp.org', '1.pool.ntp.org', '2.pool.ntp.org' ])
    }
    it {
      should contain_file('/etc/ntp.conf').with( {
        'ensure'  => 'present',
        'mode'    => '0444',
      } )
    }
  end
  context 'servers parameter' do
    let(:params) { { :servers => [ 'ntp1.example.com', 'ntp2.example.com' ] } }
    it {
      should create_class('ntp::config').with_servers([ 'ntp1.example.com', 'ntp2.example.com' ])
    }
    it {
      should contain_file('/etc/ntp.conf').with( {
        'ensure'  => 'present',
        'mode'    => '0444',
      } )
    }
  end
  context 'country parameter' do
    let(:params) { { :country => 'uk' } }
    it {
      should create_class('ntp::config').with_servers([ '0.uk.pool.ntp.org', '1.uk.pool.ntp.org', '2.uk.pool.ntp.org' ])
    }
    it {
      should contain_file('/etc/ntp.conf').with( {
        'ensure'  => 'present',
        'mode'    => '0444',
      } )
    }
  end
  context 'continent parameter' do
    let(:params) { { :continent => 'asia' } }
    it {
      should create_class('ntp::config').with_servers([ '0.asia.pool.ntp.org', '1.asia.pool.ntp.org', '2.asia.pool.ntp.org' ])
    }
    it {
      should contain_file('/etc/ntp.conf').with( {
        'ensure'  => 'present',
        'mode'    => '0444',
      } )
    }
  end
  context 'servers takes precendence over country and continent' do
    let(:params) { { :servers => [ 'ntp1.example.com' ], :country => 'za', :continent => 'asia' } }
    it {
      should create_class('ntp::config').with_servers([ 'ntp1.example.com' ])
    }
    it {
      should contain_file('/etc/ntp.conf').with( {
        'ensure'  => 'present',
        'mode'    => '0444',
      } )
    }
  end
  context 'servers unset; country takes precendence over continent' do
    let(:params) { { :country => 'za', :continent => 'asia' } }
    it {
      should create_class('ntp::config').with_servers([ '0.za.pool.ntp.org', '1.za.pool.ntp.org', '2.za.pool.ntp.org' ])
    }
    it {
      should contain_file('/etc/ntp.conf').with( {
        'ensure'  => 'present',
        'mode'    => '0444',
      } )
    }
  end
end
