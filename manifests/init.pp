# == Class: foreman
#
# Install Foreman and dependencies
#
# === Parameters
#
#  [*foreman_url*]      - Foreman URL (http://$::fqdn)
#  [*reports*]          - Foreman receives reports from Puppet (true)
#  [*unattended*]       - Foreman manages host provisioning (true)
#  [*authentication*]   - Enable users authentication in Foreman (false)
#  [*passenger*]        - Run Foreman under Apache and Passenger (true)
#  [*ssl*]              - Force SSL (note: requires passenger) (true)
#
# ==== Advanced parameters
#  See foreman::params for details.
#
#  [*custom_repo*]
#  [*use_testing*]
#  [*use_sqlite*]
#  [*railspath*]
#  [*app_root*]
#  [*user*]
#  [*environment*]
#  [*package_source*]
#  [*puppet_basedir*]
#  [*apache_conf_dir*]
#  [*puppet_home*]
#
# === Examples
#
# Install Foreman with custom URL
#
#  class{'foreman':
#    $foreman_url      => 'http://foreman.example.com/',
#  }
#  
class foreman (
  $foreman_url     = $foreman::params::foreman_url,
  $enc             = $foreman::params::enc,
  $reports         = $foreman::params::reports,
  $facts           = $foreman::params::facts,
  $storeconfigs    = $foreman::params::storeconfigs,
  $unattended      = $foreman::params::unattended,
  $authentication  = $foreman::params::authentication,
  $passenger       = $foreman::params::passenger,
  $ssl             = $foreman::params::ssl,
  $custom_repo     = $foreman::params::custom_repo,
  $use_testing     = $foreman::params::use_testing,
  $use_sqlite      = $foreman::params::use_sqlite,
  $railspath       = $foreman::params::railspath,
  $app_root        = $foreman::params::app_root,
  $user            = $foreman::params::user,
  $environment     = $foreman::params::environment,
  $puppet_basedir  = $foreman::params::puppet_basedir,
  $apache_conf_dir = $foreman::params::apache_conf_dir,
  $puppet_home     = $foreman::params::puppet_home
) inherits foreman::params {
  class { 'foreman::install': } ~>
  class { 'foreman::config': } ~>
  class { 'foreman::service': }
}
