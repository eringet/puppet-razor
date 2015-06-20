# == Class: razor::server

class razor::server (
  $database_url,
  $repo_store_root,
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

  Class['::razor::server::install'] ->
  Class['::razor::server::config'] ~>
  Class['::razor::server::service']
}
