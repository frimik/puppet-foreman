class foreman::config::enc {
  include foreman::params

  file { '/etc/puppet/node.rb':
    source => "puppet://puppet/${module_name}/external_node.rb",
    mode    => '0550',
    owner   => 'puppet',
    group   => 'puppet',
  }
  file { "/etc/puppet/foreman.yml":
    content => template("${module_name}/foreman.yml.erb"),
    mode    => '0640'
  }
  file { "${foreman::params::puppet_home}/yaml":
    ensure  => directory,
    recurse => true,
    mode    => '0640',
    owner   => 'puppet',
    group   => 'puppet',
  }
  file { "${foreman::params::puppet_home}/yaml/foreman":
    ensure  => directory,
    mode    => '0640',
    owner   => 'puppet',
    group   => 'puppet',
  }
}
