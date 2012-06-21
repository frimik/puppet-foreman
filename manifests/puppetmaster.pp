# This class includes the necessary scripts for Foreman on the puppetmaster and
# is intented to be added to your puppetmaster
class foreman::puppetmaster (
  $foreman_url  = $foreman::params::foreman_url,
  $foreman_user = $foreman::params::foreman_user,
  $foreman_pass = $foreman::params::foreman_pass,
  $reports      = $foreman::params::reports,
  $facts        = $foreman::params::facts
) inherits foreman::params {

  if $reports {
    file { "${puppet_basedir}/reports/foreman.rb":
      mode     => '0444',
      owner    => 'puppet',
      group    => 'puppet',
      source   => "puppet://puppet/${module_name}/foreman-report.rb",
      # notify => Service["puppetmaster"],
    }
  }

  if $foreman::params::enc     { include foreman::config::enc }
}
