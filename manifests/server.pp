# == Class: razor::server

class razor::server (
  $manage_database = true,
  $repo_store_root = '/var/lib/razor/repo-store',
  $db_hostname     = 'localhost',
  $db_database     = 'razor',
  $db_username     = 'razor',
  $db_password     = 'razor',
  $package_name    = undef,
  $package_ensure  = undef,
  $service_name    = undef,
  $service_ensure  = undef,
  $service_enable  = undef,
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  contain '::razor::server::install'
  contain '::razor::server::config'
  contain '::razor::server::service'

  if $manage_database {
    contain '::razor::server::database'

    Class['::razor::server::database'] ->
    Class['::razor::server::config']
  }

  Class['::razor::server::install'] ->
  Class['::razor::server::config'] ~>
  Class['::razor::server::service']
}
