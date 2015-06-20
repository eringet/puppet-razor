# == Class: razor::server::config

class razor::server::config {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  validate_string($::razor::server::database_url)
  validate_string($::razor::server::repo_store_root)

  file { '/etc/razor':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } ->

  file { '/etc/razor/config.yaml':
    ensure  => file,
    content => template("${module_name}/config.yaml.erb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  } ->

  file { $::razor::server::repo_store_root:
    ensure => directory,
    owner  => 'razor',
    group  => 'razor',
    mode   => '0755',
  } ->

  staging::extract { 'microkernel.tar':
    creates => "${::razor::server::repo_store_root}/microkernel",
    target  => $::razor::server::repo_store_root,
    require => Staging::File['microkernel.tar'],
  }
}
