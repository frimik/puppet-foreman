# This class includes the necessary scripts for Foreman on the puppetmaster and
# is intented to be added to your puppetmaster
class foreman::puppetmaster (
  $foreman_url    = $foreman::params::foreman_url,
  $foreman_user   = $foreman::params::foreman_user,
  $foreman_password = $foreman::params::foreman_password,
  $reports        = $foreman::params::reports,
  $enc            = $foreman::params::enc,
  $foreman_timeout = $foreman::params::foreman_timeout,
  $puppet_user    = $foreman::params::puppet_user,
  $puppet_group   = $foreman::params::puppet_group,
  $facts          = $foreman::params::facts,
  $storeconfigs   = $foreman::params::storeconfigs,
  $puppet_home    = $foreman::params::puppet_home,
  $puppet_basedir = $foreman::params::puppet_basedir
) inherits foreman::params {

  if $reports {   # foreman reporter
    file {"${puppet_basedir}/reports/foreman.rb":
      mode     => '0444',
      owner    => 'puppet',
      group    => 'puppet',
      source   => "puppet:///${module_name}/foreman-report.rb",
      require  => Class['::puppet::server::install'],
      # notify => Service["puppetmaster"],
    }
  }

  if $foreman::params::enc     {
    class {'foreman::config::enc':
      foreman_url  => $foreman_url,
      facts        => $facts,
      storeconfigs => $storeconfigs,
      puppet_home  => $puppet_home,
    }
  }

  file {'/etc/puppet/foreman.yml':
    content => template('foreman/foreman.yml.erb'),
    owner   => $foreman::puppetmaster::puppet_user,
    group   => $foreman::puppetmaster::puppet_group,
  }

}
